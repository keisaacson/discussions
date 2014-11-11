$('.discussions.show_leader').ready(function(){
	var emptyLeaderLists = function() {	
		$('p.no-items').remove();
		var openItems = $('ul.open-surveys-list li');
		var closedItems = $('ul.closed-surveys-list li');
		var endedItems = $('ul.ended-surveys-list li');
		var newQuestions = $('ul.questions-list li');
		var oldQuestions = $('ul.old-questions-list li');
		var responseLists = $('ul.survey-responses-list')
		if (openItems.length === 0) {
			$('ul.open-surveys-list').append('<p class="no-open no-items"><em>There are currently no open surveys.</em></p>');
		};
		if (closedItems.length === 0) {
			$('ul.closed-surveys-list').append('<p class="no-closed no-items"><em>There are currently no surveys ready to be sent.</em></p>');
		};
		if (endedItems.length === 0) {
			$('ul.ended-surveys-list').append('<p class="no-ended no-items"><em>There are currently no ended surveys.</em></p>');
		};
		if (newQuestions.length === 0) {
			$('ul.questions-list').append('<p class="no-new-questions no-items"><em>There are currently no new participant questions.</em></p>');
		};
		if (oldQuestions.length === 0) {
			$('ul.old-questions-list').append('<p class="no-old-questions no-items"><em>There are currently no participant questions that have been answered.</em></p>');
		};
		for (var i = 0; i < responseLists.length; i++) {
			var items = $(responseLists[i]).children(); 
			if (items.length === 0) {
				$(responseLists[i]).append('<p class="no-responses"><em>There were no responses to this survey.</em></p>');
			};
		};
	};

	emptyLeaderLists();

	$(document).ajaxSuccess(function() {
		emptyLeaderLists();	
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
			case 'show-answers':
				$('div.answered-questions-container').show();
				break;
			default:
				$('div.current-surveys-container').show()
				break;
		}
		$(this).addClass("active");
	});

	var channel = dispatcher.subscribe('questions');
	channel.bind('add_new_question', function(data) {
		if ($('span#question' + data['id'] + '-response-span').length == 0) {
	    	$('ul.questions-list').append('<span id="question' + data['id'] + '-response-span"><li>' + data['content'] + '</li><button class="respond-to-question-button btn btn-xs btn-default">Respond</button><form accept-charset="UTF-8" action="/questions/' + data['id'] + '" data-remote="true" method="put" id="response-question' + data['id'] + '" role="form" hidden><div style="display:none"><input name="utf8" type="hidden" value="✓"><input name=​"_method" type=​"hidden" value=​"put">​</div><div class="form-group"><input type="hidden" name="question[question_status]" value="answered"><textarea name="question[response]" class="form-control" rows="3"></textarea></div><input type="submit" value="Save Response" class="btn btn-xs btn-primary"></form></span>');
	    };
	    $('.respond-to-question-button').on('click', function(e) {
			$(e.target).next('form').show();
			$(e.target).hide();
		});
		emptyLeaderLists();
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
						$('li.open-item-' + numId + ' p.timer').text('0:0' + String(x) + ' until survey closes');
					} else if (x < 60) {
						$('li.open-item-' + numId + ' p.timer').text('0:' + String(x) + ' until survey closes');
					} else {
						var minutes = Math.floor(x/60);
						var seconds = x % 60;
						if (seconds < 10) {
							$('li.open-item-' + numId + ' p.timer').text(String(minutes) + ':0' + String(seconds) + ' until survey closes');
						} else {
						 $('li.open-item-' + numId + ' p.timer').text(String(minutes) + ':' + String(seconds) + ' until survey closes');
						};
					};
				}; 
			}(i), 1000*(totalSeconds-i));
		};
		emptyLeaderLists();
	});
})

