require 'pry-byebug'

class SurveysController < ApplicationController

  def create
    @survey = Survey.new(survey_params)
    @survey.correct_answer = 'N/A'
    @survey = set_survey_status(params['survey']['survey_action'], @survey)

    if @survey.survey_status == 'open' && @survey.save
      WebsocketRails[:surveys].trigger(:open_survey, @survey)
      @message = 'Survey created and sent successfully.'
    elsif @survey.save
      @message = 'Survey created successfully.'
    else
      @message = 'There was an error sending out the survey.'
      @error = true
    end

    respond_to do |format|
      format.js { render :layout => false }
      format.html { redirect_to "/discussions/#{@survey.discussion_id}/leader" }
    end
  end

  def update
    @survey = Survey.find(params['id'])

    if params['survey']['survey_status'] == 'open' && @survey.update(survey_params)
      WebsocketRails[:surveys].trigger(:open_survey, @survey)
      @message = 'Survey sent successfully.'
    elsif @survey.update(survey_params)
      WebsocketRails[:surveys].trigger(:end_survey, @survey)
      @message = 'Survey ended.'
    else
      @message = 'There was an error with the survey.'
      @error = true
    end

    respond_to do |format|
      format.js { render :layout => false }
      format.html { redirect_to "/discussions/#{@survey.discussion_id}/leader" }
    end
  end

  def set_survey_status(survey_action, survey)
    if survey_action == 'Create & Send Survey'
      survey.survey_status = 'open'
    else
      survey.survey_status = 'closed'
    end
    return survey
  end

  private
    def survey_params
      params.require(:survey).permit(:survey_question, :discussion_id, :survey_status)
    end
end
