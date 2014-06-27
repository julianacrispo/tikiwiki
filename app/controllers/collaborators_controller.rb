class CollaboratorsController < ApplicationController
  def show
    @users = User.all
  end

  def create
     @wiki = @wiki.find(params[:wiki_id])
     @user = @wiki.users.find(params[:user_id])
     collaborate = wiki.collaborators.build(user: @user, wiki: @wiki)

    if collaborate.save
      flash[:notice] = "Collaborators Saved"
      redirect_to @wiki
    else 
      flash[:error] = "Unable to add collaborators. Please try again"
      redirect_to @wiki
    end
  end

  def destroy
    @wiki = Wiki.find(params[:wiki_id])
    @user = @wiki.user.find(params[:user_id])
    collaborate = wiki.collaborators.find(params[:id])

    if collaborate.destroy
      flash[:notice] = "Removed Collaborator"
      redirect_to @wiki
    else 
      flash[:error] = "Unable to remove collaborator. Please try again."
      redirect_to @wiki
    end
  end



end
