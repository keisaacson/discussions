class Discussion < ActiveRecord::Base
  has_many :questions
  has_many :surveys
end
