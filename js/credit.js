$(function() {
	console.log("Credit");
	$("#viewFlatRate").hide();
	$("input.rType").change(function() {
		if($(this).val() == "spec") {
			$("#viewFlatRate").hide();
		} else if($(this).val() == "flat") {
			$("#viewFlatRate").show();
		}
	});
});