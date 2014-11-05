class Survey < ActiveRecord::Base
  belongs_to :discussion
  has_many :survey_responses

  validates_presence_of :survey_question, :discussion_id, :survey_status
end
