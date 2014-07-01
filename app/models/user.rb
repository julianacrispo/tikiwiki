class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :posts
  #has_many :managed_wikis, class: "Wiki"
  has_and_belongs_to_many :wikis

  def allowed_wikis
   wiki_ids = $redis.smembers("user-wikis-#{self.id}")
   Wiki.where(:id => wiki_ids)
   end
end
