class Post < ActiveRecord::Base
  belongs_to :wiki
  has_many :users
  # has_many :collaborations
  # has_many :users, :through => :collaborations
end
