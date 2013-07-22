class Authorization < ActiveRecord::Base

  attr_accessible :role_id, :user_id, as: [:admin]

  belongs_to :role
  belongs_to :user

  validates :role_id, presence: true, uniqueness: { scope: [:user_id] }
  validates :user_id, presence: true, uniqueness: { scope: [:role_id] }

end
