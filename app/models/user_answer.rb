class UserAnswer < ActiveRecord::Base
  validates :user_id, :answer_id, presence: true
  belongs_to :user
  belongs_to :answer
end
