class SurveyResponse < ActiveRecord::Base
  belongs_to :survey
  has_one :discussion, through: :survey
end
