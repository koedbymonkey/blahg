class Role < ActiveRecord::Base

  attr_accessible :name, as: [:admin]

  has_many :authorizations
  has_many :users, :through => :authorizations

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  def self.[] name
    where('lower(name) = ?', name.to_s.humanize.downcase).first
  end

end
