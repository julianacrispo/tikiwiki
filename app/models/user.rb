class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :posts
  #has_many :managed_wikis, class: "Wiki"
  has_and_belongs_to_many :wikis

  #TODO - fetch from redis the allowed wikis and return them
  # def allowed_wikis
  #   #user_ids = $redis.smembers("wiki-collaborators-#{@wiki.id}")
  #   # $redis.sadd("user-wikis-#{params[:user_id]}", @wiki.id) 

  # end
end
