require 'spec_helper'

describe Question do
  describe 'validations' do
    subject(:question) { Question.new }

    before { question.valid? }

    [:content, :discussion_id, :question_status].each do |attribute|
      it " should validate presence of #{attribute}" do
        expect(question).to have_at_least(1).error_on(attribute)
        expect(question.errors.messages[attribute]).to include "can't be blank"
      end
    end
  end
end
