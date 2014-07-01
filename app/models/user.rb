class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :posts
  #has_many :managed_wikis, class: "Wiki"
  has_many :wikis

  after_destroy :destroy_collaborated_wikis_before_delete


  def allowed_wikis
    wiki_ids = $redis.smembers(self.collaborated_wikis_hash_key)
    Wiki.where(:id => wiki_ids)
  end

#the key for the users that are collaborators on the wiki
  def self.collaborated_wikis_hash_key(user_id)
    "user-wikis-#{user_id}"
  end

# the key for the wikis the user is a collaborator on
  def collaborated_wikis_hash_key
    User.collaborated_wikis_hash_key(self.id)
  end
end
