class Wiki < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  belongs_to :user


  scope :visible_to, ->(user) { user ? all : where(private: false) }
  default_scope { order('created_at DESC') }

  validates :subject, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 10 }, presence: true
  validates :user, presence: true

  extend FriendlyId
  friendly_id :subject, use: [:slugged, :history]


end
