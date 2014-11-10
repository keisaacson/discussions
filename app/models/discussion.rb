class Discussion < ActiveRecord::Base
  has_many :questions
  has_many :surveys
  has_many :survey_responses, through: :surveys

  validates_presence_of :title, :leader_code, :participant_code
end
