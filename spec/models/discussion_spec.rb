require 'spec_helper'

describe Discussion do
  describe 'validations' do
    subject(:discussion) { Discussion.new }

    before { discussion.valid? }

    [:title, :leader_email].each do |attribute|
      it " should validate presence of #{attribute}" do
        expect(discussion).to have_at_least(1).error_on(attribute)
        expect(discussion.errors.messages[attribute]).to include "can't be blank"
      end
    end
  end
end
