// JavaScript Document

	function validate(){

		if(document.getElementById('course_code').value==""){
			alert("Please insert Course Code");
			document.getElementById('course_code').focus();
			return false;
		}
		else if(document.getElementById('course_name').value==""){
			alert("Please insert Course Name");
			document.getElementById('course_name').focus();
			return false;
		}
		else if(document.getElementById('course_description').value==""){
			alert("Please insert Course Description");
			document.getElementById('course_description').focus();
			return false;
		}
		else if(document.getElementById('credit_lecture').value==""){
			alert("Please insert Credit Lecture");
			document.getElementById('credit_lecture').focus();
			return false;
		}
		else if(isNaN(document.getElementById('credit_lecture').value)){
			alert('Please insert Number Only');
			document.getElementById('credit_lecture').select();
			return false;	
		}
		else if(document.getElementById('credit_lab').value==""){
			alert("Please insert Credit Lab");
			document.getElementById('credit_lab').focus();
			return false;
		}
		else if(isNaN(document.getElementById('credit_lab').value)){
			alert('Please insert Number Only');
			document.getElementById('credit_lab').select();
			return false;	
		}
		else if(document.getElementById('credit_learning').value==""){
			alert("Please insert Credit Lerning");
			document.getElementById('credit_learning').focus();
			return false;
		}
		else if(isNaN(document.getElementById('credit_learning').value)){
			alert('Please insert Credit Number Only');
			document.getElementById('credit_learning').select();
			return false;	
		}
	}