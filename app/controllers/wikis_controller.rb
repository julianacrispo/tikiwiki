class WikisController < ApplicationController
  def index
    @wikis = Wiki.visible_to(current_user)
    @wikis = current_user.wikis.friendly.all
    @wiki = Wiki.new
  end

  def show
    @wiki = Wiki.friendly.find(params[:id])
    @users = User.all
    @posts = @wiki.posts
    @post = Post.new
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

end

