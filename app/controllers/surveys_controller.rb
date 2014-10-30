require 'pry-byebug'

class SurveysController < ApplicationController

  def create
    @survey = Survey.new(survey_params)
    @survey.correct_answer = 'N/A'
    if @survey.save
      WebsocketRails[:new_survey].trigger(:send_out_survey, @survey)
      @message = 'Survey sent successfully.'
    else
      @message = 'There was an error sending out the survey.'
    end
    respond_to do |format|
      format.js { render :layout => false }
    end
  end

  private
    def survey_params
      params.require(:survey).permit(:survey_question, :discussion_id)
    end
end
