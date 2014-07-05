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

#TODO

#cleans up redis wikis when user is deleted 
#so collaboratored wikis no longer have access by the user
  def destroy_collaborated_wikis_before_delete
    #1 fetch list of wiki_ids for that the user is a collaborator on
      wiki_ids = $redis.smembers(self.collaborated_wikis_hash_key)
       #2 iterate over those wiki ids and remove instances where that user/wiki relationship exists
       #not sure about the below
    wiki_ids.each do |wiki_id|
      $redis.srem(Wiki.wiki_collaborators_hash_key(wiki_id), self.id)
    end
    $redis.del(self.collaborated_wikis_hash_key)
  end

end
