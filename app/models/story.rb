class Story < ActiveRecord::Base

  attr_accessible :body, :title, as: [:admin, :default]
  attr_accessible :author_id,    as: [:admin]

  belongs_to :author, class_name: 'User', :inverse_of => :stories

  validates :author, presence: true
  validates :title,  presence: true
  validates :body,   presence: true

end
