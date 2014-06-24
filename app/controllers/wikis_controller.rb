class WikisController < ApplicationController
  def index
    @wikis = current_user.wikis.friendly.all
    @wiki = Wiki.new
  end

  def show
    @wiki = Wiki.friendly.find(params[:id])
    if request.path != wiki_path(@wiki)
      redirect_to @wiki, status: :moved_permanently
    end
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = current_user.wikis.build(params.require(:wiki).permit(:subject, :body))
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
    if @wiki.update_attributes(params.require(:wiki).permit(:subject, :body))
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
        flash[:notice] = "List was deleted successfully"
        redirect_to @wiki
      else 
        flash[:error] = "There was an error deleting your wiki. Please try again."
        render :edit
      end
  end


end
