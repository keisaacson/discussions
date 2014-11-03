$('.discussions.show_leader').ready(function(){
	$('.view-results-button').on('click', function(e) {
		var id = e.target.id;
		var numId = id.match(/\d+/)[0];
		$('.survey-responses-div').hide();
		$('div#survey-responses-' + numId).show();
		$('.hide-results-button').show();
	});
	$('.hide-results-button').on('click', function() {
		$('.survey-responses-div').hide();
		$('.hide-results-button').hide();
	});
	$('.respond-to-question-button').on('click', function(e) {
		$(e.target).next('form').show();
		$(e.target).hide();
	});
})