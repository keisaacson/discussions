class Discussion < ActiveRecord::Base
  has_many :questions
  has_many :surveys
  has_many :survey_responses, through: :surveys
end
