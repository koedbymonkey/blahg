class Role < ActiveRecord::Base

  attr_accessible :name, as: [:admin]

  validates :name, presence: true, uniqueness: { case_sensitive: false }

end
