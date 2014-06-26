class WikisController < ApplicationController

  def create
    @wiki = Wiki.find( params[:wiki_id])
    @posts = @wiki.posts

    @post = current_user.posts.build( params.require(:post).permit(:body, :wiki_id))
    @post.wiki = @post
    @new_post = Post.new

    if @post.save
      flash[:notice] = "Post was created"
    else
      flash[:error] = "there was an error saving the post. Please try again"
    end
  end


end
