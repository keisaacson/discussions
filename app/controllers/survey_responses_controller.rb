require 'pry-byebug'

class SurveyResponsesController < ApplicationController

  def create
    @survey_response = SurveyResponse.new(survey_response_params)
    if @survey_response.save
      WebsocketRails[:new_survey_response].trigger(:submit_survey_response, @survey_response)
      @message = 'Survey response submitted successfully.'
    else
      @message = 'There was an error submitting the survey response.'
    end
    respond_to do |format|
      format.js { render :layout => false }
    end
  end

  private
    def survey_response_params
      params.require(:survey_response).permit(:survey_id, :content)
    end
end
