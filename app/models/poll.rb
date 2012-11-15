class Poll < ActiveRecord::Base
  attr_accessible :name, :poll_url, :admin_url
  has_many :questions, :dependent => :destroy

  validates :name, :presence => true, :uniqueness => true
  accepts_nested_attributes_for :questions

end
