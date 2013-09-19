$(function() {
	$("input#keyword").bind("input paste", function() {
		console.log( $("input#keyword").val());
		$.ajax( {
			url : "/AjaxSearch",
			type: "POST",
			data: {
				"keyword" : $("input#keyword").val(),
			},
			context : this,
			cache: false,
			success: function(result) {
				console.log(result);
				$("#tableAjaxContent").html(result);
			}
		});
		alert("hello");
	});
);
