$('.discussions.show').ready(function(){
	var channel = dispatcher.subscribe('surveys');
	channel.bind('open_survey', function(data) {
	  var survey_question = data['survey_question'];
	  var survey_id = data['id'];
	  var surveyResponseHtml = '<li><strong>' + survey_question + '</strong></li><div id="survey' + survey_id + '"><form accept-charset="UTF-8" action="/surveys/' + survey_id + '/survey_responses" data-remote="true" method="post" role="form"><div style="display:none"><input name="utf8" type="hidden" value="✓"></div><div class="form-group"><textarea type="text" class="form-control" rows="3" name="survey_response[content]" id="survey' + survey_id + '-response"></textarea></div><input type="hidden" name="survey_response[survey_id]" value="' + survey_id + '""><input type="submit" value="Submit Response" class="btn btn-xs btn-default"></form></div>';
	  $('p#no-surveys').remove();
	  $('ul.survey-list').append(surveyResponseHtml);
	});
	channel.bind('end_survey', function(data) {
	  var survey_id = data['id'];
	  $('div#survey' + survey_id).prev('li').remove();
	  $('div#survey' + survey_id).remove();
	});
	channel.bind('timer', function(data) {
		var totalSeconds = parseInt(data['seconds']);
		$('div#' + data['id'] + ' p.timer').remove();
		$('div#' + data['id']).prepend('<p class="timer"></p>');
		for (var i = totalSeconds; i > 0; i--) {
			setTimeout(function(x) {
				return function() { 
					if (x < 10) {
						$('div#' + data['id'] + ' p.timer').text('0:0' + String(x) + ' until survey closes');
					} else if (x < 60) {
						$('div#' + data['id'] + ' p.timer').text('0:' + String(x) + ' until survey closes');
					} else {
						var minutes = Math.floor(x/60);
						var seconds = x % 60;
						if (seconds < 10) {
							$('div#' + data['id'] + ' p.timer').text(String(minutes) + ':0' + String(seconds) + ' until survey closes');
						} else {
						 $('div#' + data['id'] + ' p.timer').text(String(minutes) + ':' + String(seconds) + ' until survey closes');
						};
					};
				}; 
			}(i), 1000*(totalSeconds-i));
		};
	});

	var channel2 = dispatcher.subscribe('questions');
	channel2.bind('respond_to_question', function(data) {
		$('p#no-questions').remove();
		$('.answered-questions-list').append('<li>' + data['content'] + '</li><p>' + data['response'] + '</p>');
	});
})