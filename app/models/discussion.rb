class Discussion < ActiveRecord::Base
  has_many :questions
end
