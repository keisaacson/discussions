require 'spec_helper'

describe Survey do
  describe 'validations' do
    subject(:survey) { Survey.new }

    before { survey.valid? }

    [:survey_question, :discussion_id, :survey_status].each do |attribute|
      it " should validate presence of #{attribute}" do
        expect(survey).to have_at_least(1).error_on(attribute)
        expect(survey.errors.messages[attribute]).to include "can't be blank"
      end
    end
  end
end
