require 'spec_helper'

describe SurveyResponse do
  describe 'validations' do
    subject(:survey_response) { SurveyResponse.new }

    before { survey_response.valid? }

    [:content, :survey_id].each do |attribute|
      it " should validate presence of #{attribute}" do
        expect(survey_response).to have_at_least(1).error_on(attribute)
        expect(survey_response.errors.messages[attribute]).to include "can't be blank"
      end
    end
  end
end
