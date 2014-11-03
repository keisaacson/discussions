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
	$('.submit-later').on('click', function(e) {
		var $timerInput = $(this).prev();
		$timerInput.show();
		$timerInput.prev().hide();
		$('.submit-later').on('click', function(e) {
			var parentForm = $(this).parent();
			var formId = $(parentForm).attr('id');
			var numSeconds = $('input[name=seconds]').val();
			var form = {
				id: formId,
				seconds: numSeconds
			};
			var channel = dispatcher.subscribe('surveys');
			setTimeout( function() {
				channel.trigger('timer', form);
			}, 500);
			setTimeout( function() {
				parentForm.submit();
			}, parseInt(numSeconds) * 1000);
			$(parentForm).hide();
		});
	});
})