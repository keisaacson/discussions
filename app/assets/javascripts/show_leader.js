$('.discussions.show_leader').ready(function(){
	var emptyList = function() {	
		$('p.no-open').remove();
		$('p.no-closed').remove();
		$('p.no-ended').remove();
		var openItems = $('ul.open-surveys-list li');
		var closedItems = $('ul.closed-surveys-list li');
		var endedItems = $('ul.ended-surveys-list li');
		if (openItems.length === 0) {
			$('ul.open-surveys-list').append('<p class="no-open"><em>There are currently no open surveys.</em></p>');
		};
		if (closedItems.length === 0) {
			$('ul.closed-surveys-list').append('<p class="no-closed"><em>There are currently no surveys ready to be sent.</em></p>');
		};
		if (endedItems.length === 0) {
			$('ul.ended-surveys-list').append('<p class="no-ended"><em>There are currently no ended surveys.</em></p>');
		};
	};

	emptyList();

	$(document).ajaxSuccess(function() {
		emptyList()
	});

	$('ul.ended-surveys-list').on('click', '.view-results-button', function(e) {
		var id = e.target.id;
		var numId = id.match(/\d+/)[0];
		$('.survey-responses-div').hide();
		$('div#survey-responses-' + numId).show();
		$('p#survey-responses-0').show();
		$('.hide-results-button').show();
	});
	$('div.survey-responses-container').on('click', '.hide-results-button', function() {
		$('.survey-responses-div').hide();
		$('p#survey-responses-0').hide();
		$('.hide-results-button').hide();
	});
	$('.respond-to-question-button').on('click', function(e) {
		$(e.target).next('form').show();
		$(e.target).hide();
	});
	$('ul.open-surveys-list').on('click', '.submit-later', function(e) {
		var $timerInput = $(this).prev();
		$timerInput.show();
		$timerInput.prev().hide();
		$(this).on('click', function(e) {
			var parentForm = $(this).parent();
			var formId = $(parentForm).attr('id');
			var numSeconds = $('#' + formId + ' input[name=seconds]').val();
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
	$('ul.nav-tabs').on('click', 'li', function() {
		$('ul.nav-tabs').children().removeClass("active");
		var tab = $(this).attr('class');
		$('div#leader-content-container').children().hide();
		$('p.message-container').empty();
		switch (tab) {
			case 'show-survey-form':
				$('div.survey-form-container').show();
				break;
			case 'show-survey-responses':
				$('div.ended-surveys-container').show();
				break;
			case 'show-questions':
				$('div.questions-container').show();
				break;
			default:
				$('div.current-surveys-container').show()
				break;
		}
		$(this).addClass("active");
	});

	var channel = dispatcher.subscribe('questions');
	channel.bind('add_new_question', function(data) {
		console.dir(data);
	    $('ul.questions-list').append('<span id="question' + data['id'] + '-response-span"><li>' + data['content'] + '</li><button class="respond-to-question-button btn btn-xs">Respond</button><form accept-charset="UTF-8" action="/questions/' + data['id'] + '" data-remote="true" method="put" id="response-question' + data['id'] + '" hidden><div style="display:none"><input name="utf8" type="hidden" value="✓"><input name=​"_method" type=​"hidden" value=​"put">​</div><textarea rows="3" cols="25" name="question[response]"></textarea><input type="hidden" name="question[question_status]" value="answered"><input type="submit" value="Save Response" class="btn btn-xs"></form></span>');
	    $('.respond-to-question-button').on('click', function(e) {
			$(e.target).next('form').show();
			$(e.target).hide();
		});
	});

	var channel2 = dispatcher.subscribe('surveys');
	channel2.bind('timer', function(data) {
		var totalSeconds = parseInt(data['seconds']);
		var numId = data['id'].match(/\d+/)[0];
		$('li.open-item-' + numId + ' p.timer').remove();
		$('li.open-item-' + numId).append('<p class="timer"></p>');
		for (var i = totalSeconds; i > 0; i--) {
			setTimeout(function(x) {
				return function() { 
					if (x < 10) {
						$('li.open-item-' + numId + ' p.timer').text('0:0' + String(x));
					} else if (x < 60) {
						$('li.open-item-' + numId + ' p.timer').text('0:' + String(x));
					} else {
						var minutes = Math.floor(x/60);
						var seconds = x % 60;
						if (seconds < 10) {
							$('li.open-item-' + numId + ' p.timer').text(String(minutes) + ':0' + String(seconds));
						} else {
						 $('li.open-item-' + numId + ' p.timer').text(String(minutes) + ':' + String(seconds));
						};
					};
				}; 
			}(i), 1000*(totalSeconds-i));
		};
	});
})

