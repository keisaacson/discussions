$('.discussions.show').ready(function(){
	var channel = dispatcher.subscribe('surveys');
	channel.bind('open_survey', function(data) {
	  var survey_question = data['survey_question'];
	  var survey_id = data['id'];
	  var surveyResponseHtml = '<div id="survey' + survey_id + '"><li>' + survey_question + '</li><form accept-charset="UTF-8" action="/surveys/' + survey_id + '/survey_responses" data-remote="true" method="post"><div style="display:none"><input name="utf8" type="hidden" value="✓"></div><input type="text" id="survey' + survey_id + '-response" name="survey_response[content]"><input type="hidden" name="survey_response[survey_id]" value="' + survey_id + '""></br><input type="submit" value="Submit Response" class="btn btn-xs"></form></div>';
	  $('ul.survey-list').append(surveyResponseHtml);
	});
	channel.bind('end_survey', function(data) {
	  var survey_id = data['id'];
	  $('div#survey' + survey_id).remove();
	});
	channel.bind('timer', function(data) {
		var totalSeconds = parseInt(data['seconds']);
		$('div#' + data['id'] + ' p.timer').remove();
		$('div#' + data['id']).append('<p class="timer">'+ totalSeconds +' seconds remaining</p>');
		for (var i = totalSeconds; i > 0; i--) {
			setTimeout(function(x) {
				return function() { 
					if (x < 10) {
						$('div#' + data['id'] + ' p.timer').text('0:0' + String(x));
					} else if (x < 60) {
						$('div#' + data['id'] + ' p.timer').text('0:' + String(x));
					} else {
						var minutes = Math.floor(x/60);
						var seconds = x % 60;
						if (seconds < 10) {
							$('div#' + data['id'] + ' p.timer').text(String(minutes) + ':0' + String(seconds));
						} else {
						 $('div#' + data['id'] + ' p.timer').text(String(minutes) + ':' + String(seconds));
						};
					};
				}; 
			}(i), 1000*(totalSeconds-i));
		};
	});

	var channel2 = dispatcher.subscribe('questions');
	channel2.bind('respond_to_question', function(data) {
		$('.answered-questions-list').append('<li>' + data['content'] + '</li><p>' + data['response'] + '</p>');
	});
})