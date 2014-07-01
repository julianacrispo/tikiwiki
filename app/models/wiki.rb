class Wiki < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  
  belongs_to :user

  scope :visible_to, ->(user) { user ? all : where(private: false) }
  default_scope { order('created_at DESC') }

  validates :subject, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 10 }, presence: true
  #validates :user, presence: true

  before_destroy :destroy_collaborators_before_delete

  extend FriendlyId
  friendly_id :subject, use: [:slugged, :history]

  def allowed_users
    user_ids = $redis.smembers(self.wiki_collaborators_hash_key)
    User.where(:id => user_ids)
  end

#cleans up redis collaborators when wiki is deleted so collaborators no longer have access to that wiki
  def destroy_collaborators_before_delete
    #1 fetch list of user_ids for wiki from redis
    user_ids = $redis.smembers(self.wiki_collaborators_hash_key)
    #2 iterate over user ids
    user_ids.each do |user_id|
      $redis.srem(User.collaborated_wikis_hash_key(user_id), self.id)
    end
    $redis.del(self.wiki_collaborators_hash_key)
  end

  def wiki_collaborators_hash_key
    "wiki-collaborators-#{self.id}"
  end
end


#### junk? ###
# $redis.sadd("wiki-collaborators-#{@wiki.id}", params[:user_id]) 
#       $redis.sadd("user-wikis-#{params[:user_id]}", @wiki.id) 


#   def collaborator_list_key
# "wiki-collaborators-#{@wiki.id}", params[:user_id]) 
#   #   $redis.sadd("user-wikis-#{params[:user_id]}", @wiki.id) 
#   # end

  # def collaborators_list_key
  #    $redis.smembers("wiki-collaborators-#{@wiki.id}", params[:user_id]) 
  #    $redis.smembers("user-wikis-#{params[:user_id]}", @wiki.id) 
  # end

 
  

