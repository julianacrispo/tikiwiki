class Wiki < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  belongs_to :user

  scope :visible_to, ->(user) { user ? all : where(private: false) }

  extend FriendlyId
  friendly_id :subject, use: [:slugged, :history]


end
