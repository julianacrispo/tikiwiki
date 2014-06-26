class CollaboratorsController < ApplicationController
  def show
    @users = User.all
  end

  def create
     @wiki = @wiki.find(params[:wiki_id])
     @user = @wiki.users.find(params[:user_id])
     collaborate = wiki.collaborators.build(user: @user)

     if collaborate.save
      flash[:notice] = "collaborators saved"
      redirect_to [@wiki]
  end

  def destroy
  end
end
