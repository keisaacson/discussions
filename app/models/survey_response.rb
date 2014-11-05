class SurveyResponse < ActiveRecord::Base
  belongs_to :survey
  has_one :discussion, through: :survey

  validates_presence_of :content, :survey_id
end
