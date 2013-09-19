import os
import jinja2
import webapp2
import json
import StringIO
import csv
from google.appengine.api import rdbms
from google.appengine.api import users
from apiclient.discovery import build
from oauth2client.appengine import OAuth2Decorator
from datetime import datetime
from pytz import timezone
import pytz
from google.appengine.ext import blobstore
from google.appengine.ext import webapp
from google.appengine.ext.webapp import blobstore_handlers
from google.appengine.ext.webapp import template
from google.appengine.ext.webapp.util import run_wsgi_app
from gaesessions import get_current_session
from gaesessions import SessionMiddleware

JINJA_ENVIRONMENT = jinja2.Environment(
	loader=jinja2.FileSystemLoader(os.path.dirname(__file__)),
    	extensions=['jinja2.ext.autoescape'])

_INSTANCE_NAME="prinya-th-2013:prinya-db"

decorator = OAuth2Decorator(
	client_id='380068443772.apps.googleusercontent.com',
	client_secret='CnXNI8-u2QgJXpUs1BrBnmPP',
	scope=['https://www.googleapis.com/auth/admin.directory.group',
		'https://www.googleapis.com/auth/plus.me'])

service = build('admin', 'directory_v1')
service_plus = build('plus', 'v1domains')

class Core():
	IS_LOGIN = 0
	UNIVERSITY_ID = -1
	DOMAIN = ""
	EMAIL = ""
	STAFF_ID = ""
	FIRSTNAME = ""
	LASTNAME = ""
	IS_SHOW_POPUP = 0
	POPUP_MSG = ""
	
	@decorator.oauth_required
	def __init__(self):
		self.response.write("Create CoreData")

	@staticmethod
	def login(self):
		user = users.get_current_user()
        	if not user:
			Core.IS_LOGIN = 0
			Core.UNIVERSITY_ID = -1
			Core.DOMAIN = ""
			Core.EMAIL = ""
			Core.STAFF_ID = ""
			Core.FIRSTNAME = ""
			Core.LASTNAME = ""
            		self.redirect(users.create_login_url(self.request.uri))
		else:
			session = get_current_session()
			if session.has_key('is_login'):
				return
			email = user.email()
			session['email'] = email
			conn = rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
    			cursor = conn.cursor()

			domain = email[email.find('@'):len(email)]
			session['domain'] = domain
			cursor.execute("SELECT university_id FROM university WHERE domain='%s' LIMIT 1"%(domain))
			row = cursor.fetchall()
			if len(row)==0:
				self.redirect('/InvalidLogin')
			else:
				session['university_id'] = row[0][0]

			cursor.execute("SELECT staff_id, firstname, lastname FROM staff WHERE email='%s' AND university_id='%s' LIMIT 1"%(email, session['university_id']))
			row = cursor.fetchall()
			if len(row)==0:
				self.redirect('/InvalidLogin')
			else:
				Core.STAFF_ID = row[0][0]
				Core.FIRSTNAME = row[0][1]
				Core.LASTNAME = row[0][2]
				Core.IS_LOGIN = 1
				session['staff_id'] = row[0][0]
				session['firstname'] = row[0][1]
				session['lastname'] = row[0][2]
				session['is_login'] = 1
				
				# self.response.write(str(core.university_id) + " \n")
				# self.response.write(core.email + " \n")
				# self.response.write(core.domain + " \n")
				# self.response.write(str(core.staff_id) + " \n")
				# self.response.write(core.firstname + " \n")
				# self.response.write(core.lastname + " \n")
				self.redirect('/')
			#self.response.write("Email: " + email)
			#self.response.write("Domain: " + domain)
			#self.response.write("Uni ID: " + str(session['university_id']))

class Logout(webapp2.RequestHandler):
	@decorator.oauth_required
	def post(self):
		Core.IS_LOGIN = 0
		Core.UNIVERSITY_ID = -1
		Core.DOMAIN = ""
		Core.EMAIL = ""
		Core.STAFF_ID = ""
		Core.FIRSTNAME = ""
		Core.LASTNAME = ""
		get_current_session().terminate()
		self.redirect(users.create_logout_url(self.request.uri))
	def get(self):
		Core.IS_LOGIN = 0
		Core.UNIVERSITY_ID = -1
		Core.DOMAIN = ""
		Core.EMAIL = ""
		Core.STAFF_ID = ""
		Core.FIRSTNAME = ""
		Core.LASTNAME = ""
		get_current_session().terminate()
		self.redirect(users.create_logout_url(self.request.uri))

class MainHandler(webapp2.RequestHandler):

	@decorator.oauth_required
	def get(self):

		Core.login(self)

		session = get_current_session()

		conn = rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
		cursor = conn.cursor()
		cursor.execute("SELECT course_id,course_code,course_name,credit_lecture,credit_lab,credit_learning,status,regiscourse_id, department, faculty FROM course natural join regiscourse WHERE university_id=" + str(session['university_id']))

		course = cursor.fetchall()

		cursor.execute('SELECT sum(capacity),sum(enroll),regiscourse_id FROM section group by regiscourse_id')
        	enroll = cursor.fetchall()
		cursor.execute("SELECT * FROM faculty WHERE university_id=" + str(session['university_id']))
		faculty = cursor.fetchall()
		templates = {
			'email' : session['email'],
			'course' : course,
			'enroll' : enroll,
			'faculty' : faculty,
		}

		template = JINJA_ENVIRONMENT.get_template('course.html')
		self.response.write(template.render(templates))	

class Toggle(webapp2.RequestHandler):
	def get(self):

		value=self.request.get('course_id');
		value=int(value)	

		conn = rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
    		cursor = conn.cursor()
    		sql1="SELECT status FROM regiscourse WHERE course_id= '%d'"%value
    		cursor.execute(sql1);
    		result=cursor.fetchall()

    		for row in result:
			if row[0]==1:
				sql2="UPDATE regiscourse set status=0 where course_id='%d'"%value

				cursor.execute(sql2);
				

			else:
				sql3="UPDATE regiscourse set status=1 where course_id='%d'"%value
				cursor.execute(sql3);

				
		conn.commit()
		conn.close()
		self.redirect("/")


class search(webapp2.RequestHandler):
  	def post(self):

		Core.login(self)

  		course_code=self.request.get('keyword');
  		year=self.request.get('year');
  		
  		semester=self.request.get('semester');
  		check_code=0
  		check_fac=0
  		check_dep=0
  		check_year=0
  		check_sem=0
  		allcheck=0
  		key_year=""
  		key_sem=""
  		code=""

  		if year=="":
  			check_year=0
  		else:
  			check_year=1
  			key_year="year="+year

  		if semester=="":
  			check_sem=0
  		else:
  			check_sem=1
  			key_sem="semester="+semester

  		if course_code == "":
  			check_code=0

  		else:
  			check_code=1
  			code="course_code like '%"+course_code+"%' "

  		data_faculty_id=self.request.get('faculty');
  		data_faculty_id=str(data_faculty_id)
  		data_faculty=""
		for row in faculty:
			if data_faculty_id == row[0]:
				data_faculty =row[1];

		if data_faculty_id =="":
			check_fac=0
		else:
			check_fac=1
  		
  		
	
		data_department=self.request.get('department');
		data_department=str(data_department)
	

		if data_department=="":
			check_dep=0
		else:
			check_dep=1

		

		where_code=" "
		a=" and "

		

		if check_code == 1:
			if check_code == 1:
				where_code+=code
			if check_year == 1:
				where_code+=a
				where_code+=key_year
			if check_sem == 1:
				where_code+=a
				where_code+=key_sem
			if check_fac == 1:
				where_code+=a
				where_code+=data_faculty
			if check_dep==1:
				where_code+=a
				where_code+=data_department
		elif check_year == 1:
			if check_year == 1:
				where_code+=key_year
			if check_sem == 1:
				where_code+=a
				where_code+=key_sem
			if check_fac == 1:
				where_code+=a
				where_code+=data_faculty
			if check_dep==1:
				where_code+=a
				where_code+=data_department
		elif check_sem == 1:
			if check_sem == 1:
				where_code+=key_sem
			if check_fac == 1:
				where_code+=a
				where_code+=data_faculty
			if check_dep==1:
				where_code+=a
				where_code+=data_department
		elif check_fac == 1:
			if check_fac == 1:
				where_code+=data_faculty
			if check_dep==1:
				where_code+=a
				where_code+=data_department
		elif check_dep==1:
			if check_dep==1:
				where_code+=data_department
		else:
			where_code="course_id = 0"

		conn = rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
    		cursor = conn.cursor()
    		sql="SELECT course_id,course_code,course_name,credit_lecture,credit_lab,credit_learning,status,regiscourse_id FROM course natural join regiscourse where %s "%(where_code)
                # sql="SELECT course_id,course_code,course_name,credit_lecture,credit_lab,credit_learning,status,regiscourse_id FROM course natural join regiscourse where course_code like '%s'"%(percent)
		cursor.execute(sql)
		conn.commit()
		

		conn2=rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
    		cursor2 = conn2.cursor()
		cursor2.execute('SELECT sum(capacity),sum(enroll),regiscourse_id FROM section group by regiscourse_id')
		conn2.commit()

		templates = {

			'course' : cursor.fetchall(),
			'enroll' : cursor2.fetchall(),

			}

		template = JINJA_ENVIRONMENT.get_template('course.html')
		self.response.write(template.render(templates))

		conn.close()
		conn2.close()

# ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class CreateHandler(webapp2.RequestHandler):
    	@decorator.oauth_required
    	def get(self):

		Core.login(self)

		session = get_current_session()		

        	conn = rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
        	cursor = conn.cursor()
        	cursor.execute("select * from course")
		course = cursor.fetchall()

		cursor.execute("SELECT * FROM faculty WHERE university_id=" + str(session['university_id']))
		faculty = cursor.fetchall()

		cursor.execute("select payment_type from university where university_id=%d"%(session['university_id']))
		pay_type = cursor.fetchall()[0][0]
        
        	templates = {
        		'email' : session['email'],
    			'course' : course,
			'pay_type' : pay_type,
			'faculty' : faculty,
    		}
    		get_template = JINJA_ENVIRONMENT.get_template('course_create.html')
    		self.response.write(get_template.render(templates));

    	

class InsertHandler(webapp2.RequestHandler):
    	@decorator.oauth_required
    	def post(self):

		Core.login(self)

		session = get_current_session()

		http = decorator.http()
        	utc = pytz.utc
        	date_object = datetime.today()
        	utc_dt = utc.localize(date_object);
        	bkk_tz = timezone("Asia/Bangkok");
        	bkk_dt = bkk_tz.normalize(utc_dt.astimezone(bkk_tz))
        	time_insert = bkk_dt.strftime("%H:%M:%S")

        	data_code = self.request.get('course_code')
		data_code = str(data_code).upper()

        	conn4 = rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
        	cursor4 = conn4.cursor()
        	cursor4.execute("select UPPER(course_code) from course")
       
                conn = rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
		cursor = conn.cursor()
      		cursor.execute("SELECT * FROM faculty WHERE university_id=" + str(session['university_id']))
		faculty = cursor.fetchall()

                count=0
                for row in cursor4.fetchall():
                    	if row[0] in data_code:
                        	count=1
                

                if count==1:
                    	self.redirect("/Error")

                else:
                        data_course_name = self.request.get('course_name')
                        data_course_description = self.request.get('course_description')
                        data_faculty_id = int(self.request.get('faculty'))
                        data_faculty = ""
                        # data_total_capacity = self.request.get('total_capacity')
                        data_department = self.request.get('department')
                        data_credit_lecture = int(self.request.get('credit_lecture'))
                        data_credit_lab = int(self.request.get('credit_lab'))
                        data_credit_learning = int(self.request.get('credit_learning'))
                        data_prerequisite = self.request.get('prerequisite')
                        data_prerequisite=int(data_prerequisite)
                    

			for row in faculty:
				if data_faculty_id == row[0]:
                            		data_faculty =row[1]

			price = self.request.get('price')
                        
                        cursor.execute("insert into course \
                        	   (course_code,course_name,course_description,credit_lecture,credit_lab,credit_learning,price,department,faculty,faculty_id) VALUES ('%s','%s','%s','%d','%d','%d','%s','%s','%s','%d')"%(data_code,data_course_name,data_course_description,data_credit_lecture,data_credit_lab,data_credit_learning,price,data_department,data_faculty,data_faculty_id))
                        conn.commit()

			params = {
				'email': "prinya-course-" + data_code + session['domain'],
				'name' : data_code
			}
	
			result = service.groups().insert(body=params).execute(http=http)

                        conn2 = rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
                        cursor2 = conn2.cursor()
                        cursor2.execute("insert into regiscourse\
                                (course_id,semester,year,status) values((select course_id from course where course_code = '%s'),1,2556,1)"%(data_code))        
                        conn2.commit()

                        conn3 = rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
                        cursor3 = conn3.cursor()
                        cursor3.execute("insert into log\
                                (staff_id,course_code,day,time,type, university_id) values((select staff_id from staff where type=2 AND email='%s' AND university_id='%s'),'%s',CURDATE(),'%s',1, '%d')"%(session['email'], session['university_id'],data_code,time_insert, session['university_id']))        
                        conn3.commit()

                        if data_prerequisite!=0:
                                cursor3.execute("insert into prerequisite_course\
                                        (course_id,type,prerequisite_id) values((select course_id from course where course_code = '%s'),1,'%s')"%(data_code,data_prerequisite))        
                                conn3.commit()

                        # self.response.write(total)
                        # self.response.write(price1)
                        # self.response.write(price2)
                        conn.close()
                        conn2.close()
                        conn3.close()
                        conn4.close()
                        self.redirect("/ModifyCourse?course_id="+data_code)


class ErrorHandler(webapp2.RequestHandler):
    	@decorator.oauth_required
    	def get(self):
        	templates = {
            		# 'course' : cursor.fetchall(),
        	}
        	get_template = JINJA_ENVIRONMENT.get_template('error.html')
        	self.response.write(get_template.render(templates));
        	# self.redirect('/')

class ErrorDelHandler(webapp2.RequestHandler):
    	def get(self):
    		course_id = self.request.get('course_id');
        	templates = {
            		'course_id' : course_id,
        	}
        	get_template = JINJA_ENVIRONMENT.get_template('errordel.html')
        	self.response.write(get_template.render(templates));
        	# self.redirect('/')


# ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


class Notification(webapp2.RequestHandler):
    	@decorator.oauth_required
	def get(self):

		Core.login(self)

		session = get_current_session()

		conn = rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
	    	cursor = conn.cursor()
		sql = ("select log_id,course_code,day,time,l.type,l.staff_id,firstname,email from log l join staff s on l.staff_id=s.staff_id where l.university_id=" + str(session['university_id']) + " order by log_id desc")
	    	
		cursor.execute(sql)

		templates = {
			'email' : session['email'],
			'log' : cursor.fetchall()
		}

		template = JINJA_ENVIRONMENT.get_template('notification.html')
		self.response.write(template.render(templates))
		
		conn.commit();	
		conn.close();

  	
    		
# ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
class DetailCourseHandler(webapp2.RequestHandler):
    	@decorator.oauth_required
    	def get(self):

		Core.login(self)

		session = get_current_session()

        	course_id = self.request.get('course_code');
        	capacity=""
        	# course_id = "BIS-101"

        	conn = rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
        	cursor = conn.cursor()
            	sql="SELECT * FROM course WHERE course_code = '%s'"%(course_id)
        	cursor.execute(sql);

            	conn2 = rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
            	cursor2 = conn2.cursor()
            	sql2="SELECT co.course_code FROM course co,prerequisite_course pre\
                	WHERE prerequisite_id=co.course_id AND pre.course_id=\
                	(SELECT course_id FROM course WHERE course_code='%s')"%(course_id)
            	cursor2.execute(sql2);
            	pre_code=""
            	for row in cursor2.fetchall():
                	pre_code=row[0]

    		conn3 = rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
        	cursor3 = conn3.cursor()
            	sql3="SELECT sum(capacity) FROM section se JOIN regiscourse re\
            	ON se.regiscourse_id=re.regiscourse_id\
            	join course co\
            	ON co.course_id=re.course_id\
            	WHERE course_code='%s'"%(course_id)
        	cursor3.execute(sql3);
        	for capa in cursor3.fetchall():
        		if capa[0]!="":
        			capacity=capa[0]
        		else:
        			capacity=0

        		
        	conn3.close();
    	

            	templates = {
			'email' : session['email'],
        		'course' : cursor.fetchall(),
        		'capacity' : capacity,
    			'prerequisite_code' : pre_code,
        	}
        	get_template = JINJA_ENVIRONMENT.get_template('course_detail.html')
        	self.response.write(get_template.render(templates));
            	conn.close();
            	conn2.close();

class ModifyCourseHandler(webapp2.RequestHandler):
    	@decorator.oauth_required
    	def get(self):

		Core.login(self)

		session = get_current_session()

        	course_id = self.request.get('course_id');

        	conn = rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
        	cursor = conn.cursor()
            	sql="SELECT * FROM course WHERE course_code = '%s'"%(course_id)
            	cursor.execute(sql);
		course = cursor.fetchall()

		cursor.execute("SELECT * FROM faculty WHERE university_id=" + str(session['university_id']))
		faculty = cursor.fetchall()

		cursor.execute('select department from course group by department')
		department = cursor.fetchall()

            	conn2 = rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
            	cursor2 = conn2.cursor()
            	sql2="SELECT course_id,course_code from course where course_code not like '%s'"%(course_id)
            	cursor2.execute(sql2);

            	conn3 = rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
            	cursor3 = conn3.cursor()
            	sql3="SELECT section_id,section_number,UPPER(CONCAT(CONCAT(firstname,' '),lastname)),enroll,capacity\
                	FROM section sec JOIN staff st ON teacher_id=staff_id\
                	WHERE regiscourse_id=(SELECT regiscourse_id FROM regiscourse WHERE course_id=\
                	(SELECT course_id from course where course_code='%s')) ORDER BY section_number"%(course_id)
            	cursor3.execute(sql3);

            	conn4 = rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
            	cursor4 = conn4.cursor()
            	sql4="SELECT co.course_id,co.course_code FROM course co,prerequisite_course pre\
                	WHERE prerequisite_id=co.course_id AND pre.course_id=\
                	(SELECT course_id FROM course WHERE course_code='%s')"%(course_id)
            	# sql4="SELECT prerequisite , CASE prerequisite WHEN '0' THEN '- NONE - ' \
            	#     ELSE (SELECT course_code FROM course WHERE course_id=\
            	#     (SELECT prerequisite FROM course WHERE course_code='%s'))\
            	#     END FROM course WHERE  course_code='%s'"%(course_id,course_id)
            	cursor4.execute(sql4);
            	pre_id=""
            	pre_code=""
            	for row in cursor4.fetchall():
                	pre_id=row[0]
                	pre_code=row[1]
		
		cursor.execute("select payment_type from university where university_id=%d"%(session['university_id']))
		pay_type = cursor.fetchall()[0][0]

            	templates = {
			'email' : session['email'],
        		'course' : course,
                	'course2' : cursor2.fetchall(),
               		'course3' : cursor3.fetchall(),
                	'course_id' : course_id,
                	'prerequisite_id' : pre_id,
                	'prerequisite_code' : pre_code,
			'faculty' : faculty,
			'department' : department,
			'pay_type' : pay_type,
			'price' : course[0][9]
        	}
        	get_template = JINJA_ENVIRONMENT.get_template('course_modify.html')
        	self.response.write(get_template.render(templates));
            	conn.close();
            	conn2.close();
            	conn3.close();
            	conn4.close();


class UpdateCourseHandler(webapp2.RequestHandler):
    	@decorator.oauth_required
    	def post(self):

		Core.login(self)

		session = get_current_session()

        	course_id = self.request.get('course_id');
            	course_name = self.request.get('course_name');
            	prerequisite = self.request.get('prerequisite');
                if prerequisite!="":
                	prerequisite=int(prerequisite)
                course_description = self.request.get('course_description');
            	credit_lecture = self.request.get('credit_lecture');
                credit_lecture=int(credit_lecture)
                credit_lab = self.request.get('credit_lab');
                credit_lab=int(credit_lab)
                credit_learning = self.request.get('credit_learning');
                credit_learning=int(credit_learning)
                # credit_type=self.request.get('credit_type');
                # credit_type=int(credit_type)
                # credit_type2=self.request.get('credit_type2');
                # credit_type2=int(credit_type2)
            	faculty = self.request.get('faculty');
                department = self.request.get('department');

        	# price = [0,1350,1350,1500,1500,1750,1350,1000,1500,1500,1350,1000,1000,1500]
         #        price1 = price[credit_type]
         #        price2 = price[credit_type2]
         #        price1 =int(price1)
         #        price2 =int(price2)
         #        total=0
         #        total=(price1*credit_lecture)+(price2*credit_lab)

	 	price = self.request.get('price')

            	conn = rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
            	cursor = conn.cursor()
        	sql="UPDATE course SET course_code = '%s' , \
                	course_name = '%s' , course_description = '%s' , \
                 	credit_lecture = '%d' , credit_lab = '%d' , \
                 	credit_learning = '%d' , department = '%s' , \
                 	faculty = '%s' ,price = '%s' \
                 	WHERE course_code = '%s'"%(course_id,course_name,course_description,credit_lecture,credit_lab,credit_learning,department,faculty,price,course_id)        
            	cursor.execute(sql);
                conn.commit();
                      
                sql="DELETE FROM prerequisite_course\
                        WHERE course_id=(SELECT course_id FROM course WHERE course_code = '%s')"%(course_id)
                cursor.execute(sql)        
                conn.commit()
                
                if prerequisite!="":
                    	sql="INSERT INTO prerequisite_course\
                                (course_id,type,prerequisite_id) VALUES((SELECT course_id FROM course WHERE course_code = '%s'),1,'%s')"%(course_id,prerequisite)
                    	cursor.execute(sql)        
                    	conn.commit()

		# params = {
		# 	'email': "prinya-course-" + course_id + Core.DOMAIN,
		# 	'name' : course_id
		# }
		# result = service.groups().update(body=params).execute(http=http)
                
                utc = pytz.utc
                date_object = datetime.today()
                utc_dt = utc.localize(date_object);
                bkk_tz = timezone("Asia/Bangkok");
                bkk_dt = bkk_tz.normalize(utc_dt.astimezone(bkk_tz))
                time_insert = bkk_dt.strftime("%H:%M:%S")

                sql="INSERT INTO log (staff_id,course_code,day,time,type, university_id)\
                    	VALUES((select staff_id from staff where type=2 AND email='%s' AND university_id='%s'),'%s',CURDATE(),'%s',4, '%d')"%(session['email'], session['university_id'],course_id,time_insert, session['university_id'])
                cursor.execute(sql)        
                conn.commit()
                conn.close();
                
                self.redirect("/ModifyCourse?course_id="+course_id)

#//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class AddSectionHandler(webapp2.RequestHandler):
    	@decorator.oauth_required
    	def get(self):

		Core.login(self)

		session = get_current_session()
        
    		course_id=self.request.get('course_id');
            	conn = rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
            	cursor = conn.cursor()
                sql="SELECT firstname FROM staff WHERE type=2 AND university_id=" + str(session['university_id'])
                cursor.execute(sql);
                templates = {
			'email' : session['email'],
                    	'course_id' : course_id,
                    	'name' : cursor.fetchall()
                }
                get_template = JINJA_ENVIRONMENT.get_template('section.html')
                self.response.write(get_template.render(templates));
                conn.commit();
                conn.close();        

class InsSectionHandler(webapp2.RequestHandler):
    	@decorator.oauth_required
    	def post(self):

		Core.login(self)

		session = get_current_session()

        	course_id=self.request.get('course_id');
                section_number=self.request.get('section_number');
                section_number=int(section_number)
                teacher=self.request.get('teacher');
                capacity=self.request.get('capacity');
                capacity=int(capacity)

                conn = rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
                cursor = conn.cursor()
                sql="INSERT INTO section (regiscourse_id,section_number,teacher_id,capacity,enroll) \
                    	VALUES ((SELECT regiscourse_id FROM regiscourse WHERE course_id=(SELECT course_id FROM course where course_code = '%s')),'%d',\
                    	(SELECT staff_id FROM staff WHERE type=2 AND firstname='%s' AND university_id='%s'),'%d','0')"%(course_id,section_number,teacher,session['university_id'],capacity)
                cursor.execute(sql);
                conn.commit();
                conn.close();

                utc = pytz.utc
                date_object = datetime.today()
                utc_dt = utc.localize(date_object);
                bkk_tz = timezone("Asia/Bangkok");
                bkk_dt = bkk_tz.normalize(utc_dt.astimezone(bkk_tz))
                time_insert = bkk_dt.strftime("%H:%M:%S")

                conn2 = rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
                cursor2 = conn2.cursor()
                sql2="INSERT INTO log (staff_id,course_code,day,time,type, university_id)\
                    	VALUES((select staff_id from staff where type=2 AND email='%s' AND university_id='%s'),'%s',CURDATE(),'%s',2, '%d')"%(session['email'], session['university_id'],course_id,time_insert, session['university_id'])
                cursor2.execute(sql2)        
                conn2.commit()
                conn2.close();

                self.redirect("/ModifyCourse?course_id="+course_id)

#//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class DetailSectionHandler(webapp2.RequestHandler):
    	@decorator.oauth_required
    	def get(self):

		Core.login(self)

		session = get_current_session()
        
                course_id=self.request.get('course_id');
                section_id=self.request.get('section_id');
                section_id=int(section_id)
                section_number=self.request.get('section_number');
                section_number=int(section_number)

                conn = rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
                cursor = conn.cursor()

                sql="SELECT section_number,firstname,capacity\
                    	FROM section sec JOIN staff st ON teacher_id=staff_id\
                    	WHERE section_id='%d' AND section_number='%d'"%(section_id,section_number)
                cursor.execute(sql);

                conn2 = rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
                cursor2 = conn2.cursor()
                sql2="SELECT sectime_id, CASE day WHEN '1' THEN 'Sunday'\
                    	WHEN '2' THEN 'Monday'\
                   	WHEN '3' THEN 'Tuesday'\
                    	WHEN '4' THEN 'Wednesday'\
                    	WHEN '5' THEN 'Thursday'\
                    	WHEN '6' THEN 'Friday'\
                    	WHEN '7' THEN 'Saturday'\
                    	ELSE 'ERROR' END,CONCAT(CONCAT(start_time,'-'),end_time),room FROM section_time WHERE section_id='%d'"%(section_id)
                cursor2.execute(sql2);



                templates = {
			'email' : session['email'],
                    	'section' : cursor.fetchall(),
                    	'time' : cursor2.fetchall(),
                    	'course_id' : course_id,
                    	'section_id' : section_id,
                    	'section_number' : section_number,
                }
                get_template = JINJA_ENVIRONMENT.get_template('secdetail.html')
                self.response.write(get_template.render(templates));
                conn.close();
                conn2.close();

class ModifySectionHandler(webapp2.RequestHandler):
    	@decorator.oauth_required
    	def get(self):
	 #    	user = users.get_current_user()
  #   		if not user:
  #       		self.redirect(users.create_login_url(self.request.uri))
		# else:
		# 	email = user.email()
		# 	conn = rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
		# 	cursor = conn.cursor()
		# 	cursor.execute("SELECT * FROM (SELECT student.email as stuemail, staff.email as semail FROM student LEFT JOIN staff ON student.student_id IS NULL UNION SELECT student.email as stuemail, staff.email as semail FROM student RIGHT JOIN staff ON student.student_id IS NULL) as Email WHERE stuemail='" + email +"' OR semail='" + email +"' LIMIT 1")
		# 	row = cursor.fetchall()
		# 	if len(row)==0:
		# 		self.redirect('/InvalidLogin')
		# 	else:
		# 		if row[0][0] is None:
		# 			user_type = "Staff"
		# 		else:
		# 			user_type = "Student"

		Core.login(self)

		session = get_current_session()

                course_id=self.request.get('course_id');
                section_id=self.request.get('section_id');
                section_id=int(section_id)
                section_number=self.request.get('section_number');
                section_number=int(section_number)
                conn = rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
                cursor = conn.cursor()

                sql="SELECT section_number,firstname,capacity\
                    	FROM section sec JOIN staff st ON teacher_id=staff_id\
                    	WHERE section_id='%d' AND section_number='%d'"%(section_id,section_number)
                cursor.execute(sql);


                conn2 = rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
                cursor2 = conn2.cursor()
                sql2="SELECT sectime_id, CASE day WHEN '1' THEN 'Sunday'\
                    	WHEN '2' THEN 'Monday'\
                    	WHEN '3' THEN 'Tuesday'\
                    	WHEN '4' THEN 'Wednesday'\
                    	WHEN '5' THEN 'Thursday'\
                    	WHEN '6' THEN 'Friday'\
                    	WHEN '7' THEN 'Saturday'\
                    	ELSE 'ERROR' END,CONCAT(CONCAT(start_time,'-'),end_time),room FROM section_time WHERE section_id='%d'"%(section_id)
                cursor2.execute(sql2);

                templates = {
			'email' : session['email'],
                    	'section' : cursor.fetchall(),
                    	'time' : cursor2.fetchall(),
                    	'course_id' : course_id,
                    	'section_id' : section_id,
                    	'section_number' : section_number,
                }
                get_template = JINJA_ENVIRONMENT.get_template('section_modify.html')
                self.response.write(get_template.render(templates));
                conn.close();
                conn2.close();

#//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class AddSectimeHandler(webapp2.RequestHandler):
    	@decorator.oauth_required
    	def get(self):
		# user = users.get_current_user()
  #   		if not user:
  #       		self.redirect(users.create_login_url(self.request.uri))
		# else:
		# 	email = user.email()
		# 	conn = rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
		# 	cursor = conn.cursor()
		# 	cursor.execute("SELECT * FROM (SELECT student.email as stuemail, staff.email as semail FROM student LEFT JOIN staff ON student.student_id IS NULL UNION SELECT student.email as stuemail, staff.email as semail FROM student RIGHT JOIN staff ON student.student_id IS NULL) as Email WHERE stuemail='" + email +"' OR semail='" + email +"' LIMIT 1")
		# 	row = cursor.fetchall()
		# 	if len(row)==0:
		# 		self.redirect('/InvalidLogin')
		# 	else:
		# 		if row[0][0] is None:
		# 			user_type = "Staff"
		# 		else:
		# 			user_type = "Student"

		Core.login(self)

		session = get_current_session()
        
                course_id=self.request.get('course_id');
                section_id=self.request.get('section_id');
                section_id=int(section_id)
                section_number=self.request.get('section_number');
                section_number=int(section_number)

                templates = {
			'email' : session['email'],
                    	'course_id' : course_id,
                    	'section_id' : section_id,
                    	'section_number' : section_number,
                }
                get_template = JINJA_ENVIRONMENT.get_template('section_time.html')
                self.response.write(get_template.render(templates));

class InsSectimeHandler(webapp2.RequestHandler):
    	@decorator.oauth_required
    	def post(self):
	 #    	user = users.get_current_user()
  #   		if not user:
  #       		self.redirect(users.create_login_url(self.request.uri))
		# else:
		# 	email = user.email()
		# 	conn = rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
		# 	cursor = conn.cursor()
		# 	cursor.execute("SELECT * FROM (SELECT student.email as stuemail, staff.email as semail FROM student LEFT JOIN staff ON student.student_id IS NULL UNION SELECT student.email as stuemail, staff.email as semail FROM student RIGHT JOIN staff ON student.student_id IS NULL) as Email WHERE stuemail='" + email +"' OR semail='" + email +"' LIMIT 1")
		# 	row = cursor.fetchall()
		# 	if len(row)==0:
		# 		self.redirect('/InvalidLogin')
		# 	else:
		# 		if row[0][0] is None:
		# 			user_type = "Staff"
		# 		else:
		# 			user_type = "Student"

		Core.login(self)

		session = get_current_session()

                course_id=self.request.get('course_id');
                section_id=self.request.get('section_id');
                section_id=int(section_id)
                section_number=self.request.get('section_number');
                section_number=int(section_number)
                day=self.request.get('day');
                day=int(day)
                start_time=self.request.get('start_time');
                end_time=self.request.get('end_time');
                room=self.request.get('roomid');

                conn = rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
                cursor = conn.cursor()
                sql="INSERT INTO section_time (day,start_time,end_time,room,section_id)\
                    	VALUES ('%d','%s','%s','%s','%d')"%(day,start_time,end_time,room,section_id)
                cursor.execute(sql);
                conn.commit();
                conn.close();

                utc = pytz.utc
                date_object = datetime.today()
                utc_dt = utc.localize(date_object);
                bkk_tz = timezone("Asia/Bangkok");
                bkk_dt = bkk_tz.normalize(utc_dt.astimezone(bkk_tz))
                time_insert = bkk_dt.strftime("%H:%M:%S")

                conn2 = rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
                cursor2 = conn2.cursor()
        	sql2="INSERT INTO log (staff_id,course_code,day,time,type, university_id)\
                    	VALUES((select staff_id from staff where type=2 AND email='%s' AND university_id='%s'),'%s',CURDATE(),'%s',3, '%d')"%(session['email'], session['university_id'],course_id,time_insert, session['university_id'])
                cursor2.execute(sql2)        
                conn2.commit()
                conn2.close();

                self.redirect("/ModifySection?course_id="+str(course_id)+"&section_id="+str(section_id)+"&section_number="+str(section_number));

#//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class DeleteCourseHandler(webapp2.RequestHandler):
    	@decorator.oauth_required
    	def get(self):
		# user = users.get_current_user()
  #   		if not user:
  #       		self.redirect(users.create_login_url(self.request.uri))
		# else:
		# 	email = user.email()
		# 	conn = rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
		# 	cursor = conn.cursor()
		# 	cursor.execute("SELECT * FROM (SELECT student.email as stuemail, staff.email as semail FROM student LEFT JOIN staff ON student.student_id IS NULL UNION SELECT student.email as stuemail, staff.email as semail FROM student RIGHT JOIN staff ON student.student_id IS NULL) as Email WHERE stuemail='" + email +"' OR semail='" + email +"' LIMIT 1")
		# 	row = cursor.fetchall()
		# 	if len(row)==0:
		# 		self.redirect('/InvalidLogin')
		# 	else:
		# 		if row[0][0] is None:
		# 			user_type = "Staff"
		# 		else:
		# 			user_type = "Student"

		Core.login(self)

		session = get_current_session()

                http = decorator.http()
                course_id=self.request.get('course_id')
        	section_id=""
                prerequisite=""
                sectime=""
         #        check=""
        	
        	# conn10 = rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
         #        cursor10 = conn10.cursor()
         #        sql10="SELECT p_id FROM prerequisite_course WHERE prerequisite_id IN \
         #        	(SELECT course_id FROM course WHERE course_code='%s')"%(course_id)
         #        cursor10.execute(sql10);
         #        for row in cursor10.fetchall():
         #            	check=row[0]
         #        conn10.commit();
         #        conn10.close();

         #        if check!="":
         #        	self.redirect("/ErrorDel?course_id="+course_id);
         #        else:
        	#         conn5 = rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
        	#         cursor5 = conn5.cursor()
        	#         sql5="SELECT section_id,sectime_id FROM section_time WHERE section_id IN\
        	#             (SELECT section_id FROM section WHERE regiscourse_id = \
        	#             (SELECT regiscourse_id FROM regiscourse WHERE course_id=\
        	#             (SELECT course_id FROM course WHERE course_code='%s')))"%(course_id)
        	#         cursor5.execute(sql5);
        	#         for row in cursor5.fetchall():
        	#             	sectime=row[0]
        	#         conn5.commit();
        	#         conn5.close();

        	#         conn9 = rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
        	#         cursor9 = conn9.cursor()
        	#         sql9="SELECT section_id FROM section WHERE section_id IN\
        	#             (SELECT section_id FROM section WHERE regiscourse_id = \
        	#             (SELECT regiscourse_id FROM regiscourse WHERE course_id=\
        	#             (SELECT course_id FROM course WHERE course_code='%s')))"%(course_id)
        	#         cursor9.execute(sql9);
        	#         for row in cursor9.fetchall():
        	#             	section_id=row[0]
        	#         conn9.commit();
        	#         conn9.close();

        	#         if section_id!="":
        	#             	if sectime!="":
        	#                 	conn4 = rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
        	#                 	cursor4 = conn4.cursor()
        	#                 	sql4="DELETE FROM  section_time WHERE section_id IN\
        	#                    	 (SELECT section_id FROM section WHERE regiscourse_id = \
        	#                    	 (SELECT regiscourse_id FROM regiscourse WHERE course_id=\
        	#                   	  (SELECT course_id FROM course WHERE course_code='%s')))"%(course_id)
        	#                		cursor4.execute(sql4);
        	#                 	conn4.commit();
        	#                 	conn4.close();

        	#             	conn6 = rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
        	#             	cursor6 = conn6.cursor()
        	#             	sql6="DELETE FROM section WHERE regiscourse_id = \
        	#                 	(SELECT regiscourse_id FROM regiscourse WHERE course_id=\
        	#                 	(SELECT course_id FROM course WHERE course_code='%s'))"%(course_id)
        	#             	cursor6.execute(sql6);
        	#             	conn6.commit();
        	#             	conn6.close();

        	#         conn8 = rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
        	#         cursor8 = conn8.cursor()
        	#         sql8="SELECT prerequisite_id FROM prerequisite_course\
        	#                     WHERE course_id=(SELECT course_id FROM course WHERE course_code = '%s')"%(course_id)
        	#         cursor8.execute(sql8)
        	#         for row in cursor8.fetchall():
        	#             	prerequisite=row[0]       
        	#         conn8.commit()
        	#         conn8.close();

        	#         if prerequisite!="":
        	#             	conn7 = rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
        	#             	cursor7 = conn7.cursor()
        	#             	sql7="DELETE FROM prerequisite_course\
        	#                     WHERE course_id=(SELECT course_id FROM course WHERE course_code = '%s')"%(course_id)
        	#             	cursor7.execute(sql7)        
        	#             	conn7.commit()
        	#             	conn7.close();

        	        
        	        
        	#         conn = rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
        	#         cursor = conn.cursor()
        	#         sql="DELETE FROM regiscourse WHERE course_id=(SELECT course_id FROM course WHERE course_code='%s')"%(course_id)
        	#         cursor.execute(sql);
        	#         conn.commit();
        	#         conn.close();

    	        conn = rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
    	        cursor = conn.cursor()
    	        sql="DELETE FROM course WHERE course_code='%s' AND university_id='%s'"%(course_id, str(session['university_id']))
    	        cursor.execute(sql);
    	        conn.commit();

    	        utc = pytz.utc
    	        date_object = datetime.today()
    	        utc_dt = utc.localize(date_object);
    	        bkk_tz = timezone("Asia/Bangkok");
    	        bkk_dt = bkk_tz.normalize(utc_dt.astimezone(bkk_tz))
    	        time_insert = bkk_dt.strftime("%H:%M:%S")

    	        sql="INSERT INTO log (staff_id,course_code,day,time,type, university_id)\
    	            	VALUES((select staff_id from staff where type=2 AND email='%s' AND university_id='%s'),'%s',CURDATE(),'%s',5, '%d')"%(session['email'], session['university_id'],course_id,time_insert, session['university_id'])
    	        cursor.execute(sql)        
    	        conn.commit()
    	        conn.close();

    		email = "prinya-course-" + course_id + session['domain']
    		result = service.groups().delete(groupKey=email).execute(http=http)

    	        self.redirect("/");        


class DeleteSectionHandler(webapp2.RequestHandler):
    	@decorator.oauth_required
   	def get(self):
		# user = users.get_current_user()
  #   		if not user:
  #       		self.redirect(users.create_login_url(self.request.uri))
		# else:
		# 	email = user.email()
		# 	conn = rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
		# 	cursor = conn.cursor()
		# 	cursor.execute("SELECT * FROM (SELECT student.email as stuemail, staff.email as semail FROM student LEFT JOIN staff ON student.student_id IS NULL UNION SELECT student.email as stuemail, staff.email as semail FROM student RIGHT JOIN staff ON student.student_id IS NULL) as Email WHERE stuemail='" + email +"' OR semail='" + email +"' LIMIT 1")
		# 	row = cursor.fetchall()
		# 	if len(row)==0:
		# 		self.redirect('/InvalidLogin')
		# 	else:
		# 		if row[0][0] is None:
		# 			user_type = "Staff"
		# 		else:
		# 			user_type = "Student"

		Core.login(self)

		session = get_current_session()
    	
        	course_id=self.request.get('course_id')

                conn = rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
                cursor = conn.cursor()
            	
                section_id=self.request.get('section_id')
                section_id=int(section_id)

                sql="DELETE FROM section WHERE section_id='%d'"%(section_id)
                cursor.execute(sql);
                conn.commit();

                utc = pytz.utc
                date_object = datetime.today()
                utc_dt = utc.localize(date_object);
                bkk_tz = timezone("Asia/Bangkok");
                bkk_dt = bkk_tz.normalize(utc_dt.astimezone(bkk_tz))
                time_insert = bkk_dt.strftime("%H:%M:%S")

                sql="INSERT INTO log (staff_id,course_code,day,time,type, university_id)\
                    	VALUES((select staff_id from staff where type=2 AND email='%s' AND university_id='%s'),'%s',CURDATE(),'%s',6, '%d')"%(session['email'], session['university_id'],course_id,time_insert, session['university_id'])
                cursor.execute(sql)        
                conn.commit()
                conn.close();

                self.redirect("/ModifyCourse?course_id="+course_id)        

class DeleteSectimeHandler(webapp2.RequestHandler):
    	@decorator.oauth_required
    	def get(self):
  #       	user = users.get_current_user()
  #   		if not user:
  #       		self.redirect(users.create_login_url(self.request.uri))
		# else:
		# 	email = user.email()
		# 	conn = rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
		# 	cursor = conn.cursor()
		# 	cursor.execute("SELECT * FROM (SELECT student.email as stuemail, staff.email as semail FROM student LEFT JOIN staff ON student.student_id IS NULL UNION SELECT student.email as stuemail, staff.email as semail FROM student RIGHT JOIN staff ON student.student_id IS NULL) as Email WHERE stuemail='" + email +"' OR semail='" + email +"' LIMIT 1")
		# 	row = cursor.fetchall()
		# 	if len(row)==0:
		# 		self.redirect('/InvalidLogin')
		# 	else:
		# 		if row[0][0] is None:
		# 			user_type = "Staff"
		# 		else:
		# 			user_type = "Student"

		Core.login(self)

		session = get_current_session()

            	course_id=self.request.get('course_id')
            	sectime_id=self.request.get('sectime_id')
                sectime_id=int(sectime_id)
                section_id=self.request.get('section_id')
                section_id=int(section_id)
                section_number=self.request.get('section_number')
                section_number=int(section_number)
                conn = rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
                cursor = conn.cursor()
                sql="DELETE FROM section_time WHERE sectime_id='%d'"%(sectime_id)
                cursor.execute(sql)
                conn.commit()
                conn.close()

                utc = pytz.utc
                date_object = datetime.today()
                utc_dt = utc.localize(date_object)
                bkk_tz = timezone("Asia/Bangkok")
                bkk_dt = bkk_tz.normalize(utc_dt.astimezone(bkk_tz))
                time_insert = bkk_dt.strftime("%H:%M:%S")

                conn2 = rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
                cursor2 = conn2.cursor()
                sql2="INSERT INTO log (staff_id,course_code,day,time,type, university_id)\
                    VALUES((select staff_id from staff where type=2 AND email='%s' AND university_id='%s'),'%s',CURDATE(),'%s',7, '%d')"%(session['email'], session['university_id'],course_id,time_insert, session['university_id'])
                cursor2.execute(sql2)        
                conn2.commit()
                conn2.close()

                self.redirect("/ModifySection?course_id="+course_id+"&section_id="+str(section_id)+"&section_number="+str(section_number));

class InvalidLogin(webapp2.RequestHandler):
	def get(self):
		self.response.write("Invalid Login")

class AjaxSearch(webapp2.RequestHandler):
	def post(self):
		session = get_current_session()

		key = self.request.get('keyword')
		# dept = self.request.get('dept')
		conn = rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
    		cursor = conn.cursor()
        	sql = "SELECT course_id,course_code,course_name,credit_lecture,credit_lab,credit_learning,status,regiscourse_id, department, faculty FROM course natural join regiscourse WHERE university_id='" + str(session['university_id']) + "' AND (course_code LIKE '%" + key + "%' OR course_name LIKE '%" + key + "%')"
        	cursor.execute(sql)

		course = cursor.fetchall()
		templates = {
			'course' : course,
		}
		conn.close()

		template = JINJA_ENVIRONMENT.get_template('course_ajax.html')
		self.response.write(template.render(templates))

class ManageUser(webapp2.RequestHandler):
	@decorator.oauth_required
	def get(self):
		# user = users.get_current_user()
  #       	if not user:
  #           		self.redirect(users.create_login_url(self.request.uri))
		# else:
		# 	email = user.email()
		# 	conn = rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
  #   			cursor = conn.cursor()
		# 	cursor.execute("SELECT * FROM (SELECT student.email as stuemail, staff.email as semail FROM student LEFT JOIN staff ON student.student_id IS NULL UNION SELECT student.email as stuemail, staff.email as semail FROM student RIGHT JOIN staff ON student.student_id IS NULL) as Email WHERE stuemail='" + email +"' OR semail='" + email +"' LIMIT 1")
		# 	row = cursor.fetchall()
		# 	if len(row)==0:
		# 		self.redirect('/InvalidLogin')
		# 	else:
		# 		if row[0][0] is None:
		# 			user_type = "Staff"
		# 		else:
		# 			user_type = "Student"

		Core.login(self)

		session = get_current_session()
		
		conn = rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
		cursor = conn.cursor()
		sql = "SELECT student_id , student_code , email , firstname ,lastname , university_id FROM student WHERE university_id='%s'"%(session['university_id'])
		cursor.execute(sql)
		students = cursor.fetchall()
		sql = "SELECT staff_id , email , firstname ,lastname , university_id FROM staff WHERE university_id='%s'"%(session['university_id'])
		cursor.execute(sql)
		staffs = cursor.fetchall()

		upload_url = blobstore.create_upload_url('/upload')

		templates = {
			'showPopup' : "0",
			'popupMSG' : "User Deleted",
			'students' : students,
			'staffs' : staffs,
			'email' : session['email'],
			'upload_url' : upload_url
		}
		template = JINJA_ENVIRONMENT.get_template('manage_user.html')
		self.response.write(template.render(templates))

		#self.response.out.write('<html><body>')
		#self.response.out.write('<form action="%s" method="POST" enctype="multipart/form-data">' % upload_url)
		#self.response.out.write('<select name="stype"><option value="student">Student</option><option value="staff">Staff</option><select><br>')
		#self.response.out.write("""Upload File: <input type="file" name="file"><br> <input type="submit" name="submit" value="Submit"> </form></body></html>""")		

class UserDelete(webapp2.RequestHandler):
	def post(self):
		user_id = self.request.get('user_id')
		user_type = self.request.get('user_type')
		conn = rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
		cursor = conn.cursor()
		if user_type == "student":
			sql = "DELETE FROM student WHERE student_id='%s'"%(user_id)
		else:
			sql = "DELETE FROM staff WHERE staff_id='%s'"%(user_id)
		cursor.execute(sql)
		conn.commit()
		conn.close()
		self.redirect('/ManageUser')

class UploadHandler(blobstore_handlers.BlobstoreUploadHandler):
	def post(self):
		session = get_current_session()

		stype = self.request.get('stype')
		upload_files = self.get_uploads('file')
		blob_info = upload_files[0]
		blob_reader = blobstore.BlobReader(blob_info.key())
		value = blob_reader.read()
		f = StringIO.StringIO(value)
		reader = csv.reader(f, delimiter=',')
		i = 0
		sql = ""
        	conn = rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
       		cursor = conn.cursor()
		if stype == "student":
			for row in reader:
				break;
				if i !=0 :
					sql = "INSERT INTO student (firstname,lastname, email, university_id) VALUES (\'" + row[5] + "\',\'" + row[6] + "\',\'" + row[7] + "\'" + session['university_id'] + ");"
				i += 1
		elif stype == "staff":
			for row in reader:
				if i !=0 :
					sql = "INSERT INTO staff (firstname,lastname, email, university_id) VALUES (\'" + row[0] + "\',\'" + row[1] + "\',\'" + row[2] + "\'" + session['university_id'] + ");"
        				cursor.execute(sql);
        				conn.commit();
				i += 1

        	conn.close();
		self.response.out.write("Import User Successfully")

class Credit(webapp2.RequestHandler):
	@decorator.oauth_required
	def get(self):
		# user = users.get_current_user()
  #   		if not user:
  #       		self.redirect(users.create_login_url(self.request.uri))
		# else:
		# 	email = user.email()
		# 	conn = rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
		# 	cursor = conn.cursor()
		# 	cursor.execute("SELECT * FROM (SELECT student.email as stuemail, staff.email as semail FROM student LEFT JOIN staff ON student.student_id IS NULL UNION SELECT student.email as stuemail, staff.email as semail FROM student RIGHT JOIN staff ON student.student_id IS NULL) as Email WHERE stuemail='" + email +"' OR semail='" + email +"' LIMIT 1")
		# 	row = cursor.fetchall()
		# 	if len(row)==0:
		# 		self.redirect('/InvalidLogin')
		# 	else:
		# 		if row[0][0] is None:
		# 			user_type = "Staff"
		# 		else:
		# 			user_type = "Student"

		Core.login(self)

		session = get_current_session()

		conn = rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
    		cursor = conn.cursor()
		cursor.execute("SELECT * FROM faculty WHERE university_id=" + str(session['university_id']))
		faculty = cursor.fetchall()
		templates = {
			'email' : session['email'],
			'faculty' : faculty
		}
		template = JINJA_ENVIRONMENT.get_template('credit.html')
		self.response.write(template.render(templates))

class CreditHandler(webapp2.RequestHandler):
	def post(self):
		pay_type = self.request.get('rate')
		faculty = self.request.get('faculty')
		department = self.request.get('department')
		price = self.request.get('price')

		conn = rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
    		cursor = conn.cursor()

		if pay_type == "spec":
			sql = "update university set payment_type=1"
			cursor.execute(sql)
			conn.commit();
		elif pay_type == "flat":
			sql = "update university set payment_type=2"
			cursor.execute(sql)
			conn.commit();

			sql = "update department set fee='%s' where department_name='%s' and faculty_id='%s'"%(price, department, faculty)
			self.response.write(sql)
			cursor.execute(sql)
			conn.commit()

		conn.close()
		self.redirect('/')

class ManageFaculty(webapp2.RequestHandler):
	def post(self):
		session = get_current_session()
		conn = rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
		cursor = conn.cursor()
		mode = self.request.get('mode')
		if mode == "add":
			title = self.request.get('title')
			maxcredit_per_semester = self.request.get('maxcredit_per_semester')
			fee = self.request.get('fee')
			department = self.request.get('department')
			sql = "INSERT INTO faculty(title,maxcredit_per_semester,fee,department, university_id) VALUES('%s','%s','%s','%s', '%s')"%(title,maxcredit_per_semester,fee,department, str(session['university_id']))
			cursor.execute(sql)
			conn.commit()
			conn.close()
			self.response.write("Add Successfully<br><a href='/ManageFaculty'>back</a>")
		if mode == "delete":
			faculty_id = self.request.get('faculty_id')
			sql = "DELETE FROM faculty WHERE faculty_id='%s'"%(faculty_id)
			cursor.execute(sql)
			conn.commit()
			conn.close()
			self.response.write("Delete Successfully<br><a href='/ManageFaculty'>back</a>")
		if mode == "edit":
			title = self.request.get('title')
			maxcredit_per_semester = self.request.get('maxcredit_per_semester')
			fee = self.request.get('fee')
			faculty_id = self.request.get('faculty_id')
			department = self.request.get('department')
			sql = "UPDATE faculty SET title='%s',maxcredit_per_semester='%s',fee='%s',department='%s' WHERE faculty_id='%s'"%(title,maxcredit_per_semester,fee,department,faculty_id)
			cursor.execute(sql)
			conn.commit()
			conn.close()
			self.response.write("Update Successfully<br><a href='/ManageFaculty'>back</a>")

	def get(self):
		session = get_current_session()

		conn = rdbms.connect(instance=_INSTANCE_NAME, database='Prinya_Project')
		cursor = conn.cursor()
		sql = "SELECT faculty_id , title , maxcredit_per_semester , fee , department FROM faculty WHERE university_id=" + str(session['university_id'])
		cursor.execute(sql)
		faculty = cursor.fetchall()
		templates = {
			'email' : session['email'],
			'faculty' : faculty
		}
		template = JINJA_ENVIRONMENT.get_template('addfaculty.html')
		self.response.write(template.render(templates))


app = webapp2.WSGIApplication([
	('/', MainHandler),
	('/toggle',Toggle),
	('/search',search),
	('/Create', CreateHandler),
	('/Insert', InsertHandler),
	('/Error', ErrorHandler),
	('/Notification',Notification),
	('/DetailCourse',DetailCourseHandler),
	('/ModifyCourse',ModifyCourseHandler),
	('/UpdateCourse',UpdateCourseHandler),
	('/AddSection',AddSectionHandler),
	('/InsSection',InsSectionHandler),
	('/AddSectime',AddSectimeHandler),
	('/InsSectime',InsSectimeHandler),
	('/DetailSection',DetailSectionHandler),
	('/ModifySection',ModifySectionHandler),
	('/DeleteCourse',DeleteCourseHandler),
	('/DeleteSection',DeleteSectionHandler),
	('/DeleteSectime',DeleteSectimeHandler),
	('/InvalidLogin',InvalidLogin),
	('/AjaxSearch',AjaxSearch),
	('/upload', UploadHandler),
	('/ManageUser', ManageUser),
	('/ManageFaculty', ManageFaculty),
	('/UserDelete', UserDelete),
	('/Credit', Credit),
	('/CreditHandler', CreditHandler),
	('/Logout', Logout),
	(decorator.callback_path, decorator.callback_handler())    
], debug=True)
app = SessionMiddleware(app, cookie_key=str(os.urandom(64)))