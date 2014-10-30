class Survey < ActiveRecord::Base
  belongs_to :discussion
  has_many :survey_responses
end
