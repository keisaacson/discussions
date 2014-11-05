class Question < ActiveRecord::Base
  belongs_to :discussion

  validates_presence_of :content, :discussion_id, :question_status
end
