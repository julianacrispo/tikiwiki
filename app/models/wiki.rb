class Wiki < ActiveRecord::Base
  has_many :posts
  belongs_to :user

  extend FriendlyId
  friendly_id :subject, use: [:slugged, :history]

  # Wiki.create! subject: "Joeschmoe"

end
