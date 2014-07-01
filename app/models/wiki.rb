class Wiki < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  
  #belongs_to :owner, class: "User"
  has_and_belongs_to_many :users

  scope :visible_to, ->(user) { user ? all : where(private: false) }
  default_scope { order('created_at DESC') }

  validates :subject, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 10 }, presence: true
  #validates :user, presence: true

  extend FriendlyId
  friendly_id :subject, use: [:slugged, :history]

#added
   accepts_nested_attributes_for :users

  def allowed_users
    user_ids = $redis.smembers("wiki-collaborators-#{self.id}")
    User.where(:id => user_ids)
  end
end


#   def collaborator_list_key
# "wiki-collaborators-#{@wiki.id}", params[:user_id]) 
#   #   $redis.sadd("user-wikis-#{params[:user_id]}", @wiki.id) 
#   # end

  # def collaborators_list_key
  #    $redis.smembers("wiki-collaborators-#{@wiki.id}", params[:user_id]) 
  #    $redis.smembers("user-wikis-#{params[:user_id]}", @wiki.id) 
  # end

 
  

