$(document).ready(function() {
	if ($(".flash").text().length > 0) {
		$(".flash").slideDown().delay(4000).slideUp(1000);
	}
});

//$(function() {
//  $( ".datepickers" ).datepicker({ dateFormat: 'yy-mm-dd' });
//});
