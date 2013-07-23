class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable and :omniauthable
  devise :confirmable, :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email,
                  :password,
                  :password_confirmation,
                  :remember_me,
                  :username,
                  as: [:admin, :default]

  attr_accessible :admin, as: [:admin]

  has_many :authorizations
  has_many :roles, :through => :authorizations

  has_many :stories, foreign_key: 'author_id', :inverse_of => :author

  validates :username, presence: true, uniqueness: true

  after_create :add_commenter_role

  def has_role? role
    role_ids.include? Role[role].id
  end

private

  def add_commenter_role
    roles << Role['commenter']
  end

end
