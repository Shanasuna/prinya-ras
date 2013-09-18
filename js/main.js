$(function() {
	$("input#keyword").bind("input paste", function() {
		console.log( $("input#keyword").val());
		$.ajax( {
			url : "/AjaxSearch",
			type: "POST",
			data: {
				"keyword" : $("input#keyword").val(),
				"department" : $("input#dept").val(),
				"faculty" : $("input#fac").val(),
				"credit" : $("input#credit").val(),
				"status" : $("input#status").val()
			},
			context : this,
			cache: false,
			success: function(result) {
				console.log(result);
				$("#tableAjaxContent").html(result);
			}
		});
	});
	$("input#dept").bind("input paste", function() {
		console.log( $("input#dept").val());
		$.ajax( {
			url : "/AjaxSearch",
			type: "POST",
			data: {
				"keyword" : $("input#keyword").val(),
				"department" : $("input#dept").val(),
				"faculty" : $("input#fac").val(),
				"credit" : $("input#credit").val(),
				"status" : $("input#status").val()
			},
			context : this,
			cache: false,
			success: function(result) {
				console.log(result);
				$("#tableAjaxContent").html(result);
			}
		});
	});
	$("input#fac").bind("input paste", function() {
		console.log( $("input#fac").val());
		$.ajax( {
			url : "/AjaxSearch",
			type: "POST",
			data: {
				"keyword" : $("input#keyword").val(),
				"department" : $("input#dept").val(),
				"faculty" : $("input#fac").val(),
				"credit" : $("input#credit").val(),
				"status" : $("input#status").val()
			},
			context : this,
			cache: false,
			success: function(result) {
				console.log(result);
				$("#tableAjaxContent").html(result);
			}
		});
	});
	$("input#status").bind("input paste", function() {
		console.log( $("input#status").val());
		$.ajax( {
			url : "/AjaxSearch",
			type: "POST",
			data: {
				"keyword" : $("input#keyword").val(),
				"department" : $("input#dept").val(),
				"faculty" : $("input#fac").val(),
				"credit" : $("input#credit").val(),
				"status" : $("input#status").val()
			},
			context : this,
			cache: false,
			success: function(result) {
				console.log(result);
				$("#tableAjaxContent").html(result);
			}
		});
	});
});