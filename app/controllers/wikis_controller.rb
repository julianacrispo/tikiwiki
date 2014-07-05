class WikisController < ApplicationController
  def index
    @wikis = current_user.allowed_wikis.to_a
    @wikis += current_user.wikis
    @wiki = Wiki.new

    @collaborators = $redis.smembers("wiki-collaborators-#{@wiki.id}")
  end

  def show
    @wiki = Wiki.friendly.find(params[:id])
    @users = @wiki.allowed_users

    if request.path != wiki_path(@wiki)
      redirect_to @wiki, status: :moved_permanently
    end
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = current_user.wikis.build(params.require(:wiki).permit(:subject, :body, :private))
    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
    else
      flash[:error] = "there was an error saving the wiki. Please try again"
      render :new
    end

  end

  def edit
    @wiki = Wiki.friendly.find(params[:id])
    @users = @wiki.users
    @users = User.all
  end

  def update
    @wiki = Wiki.friendly.find(params[:id])
    if @wiki.update_attributes(params.require(:wiki).permit(:subject, :body, :private))
      flash[:notice] = "Wiki was updated"
      redirect_to @wiki
    else 
      flash[:error] = "There was an error saving the wiki. Please try again. "
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.friendly.find(params[:id])
      if @wiki.destroy
        flash[:notice] = "Wiki was deleted successfully"
        redirect_to @wiki
      else 
        flash[:error] = "There was an error deleting your Wiki. Please try again."
        render :edit
      end
    end

  def add_collaborator
    @wiki = Wiki.find(params[:id])
    if params[:user_id].present? && current_user.premium 
      $redis.sadd(@wiki.wiki_collaborators_hash_key, params[:user_id]) 
      $redis.sadd(User.collaborated_wikis_hash_key(params[:user_id]), @wiki.id) 

      flash[:notice] = "#{params[:user_id]} was added to the collaborators list"
      render :show
    else
      flash[:error] = "Collaborator couldn't be added"
        render :edit
    end
  end 

#TODO, and implement view to remove collaborators from the wiki
  def remove_collaborator
    @wiki = Wiki.find(params[:id])
    if params[:user_id].present?
      $redis.srem(@wiki.wiki_collaborators_hash_key, params[:user_id]) 
      $redis.srem(User.collaborated_wikis_hash_key(params[:user_id]), @wiki.id)

      flash[:notice] = "#{params[:user_id]} was deleted from the collaborators list"
      render :show
    else
      flash[:error] = "Collaborator couldn't be deleted"
        render :edit
    end
  end
end

