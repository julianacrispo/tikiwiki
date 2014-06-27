class PostsController < ApplicationController
  def create

    @wiki = current_user.wikis.friendly.find(params[:wiki_id])
    @post = @wiki.posts.build(post_params)
    @post.wiki = @wiki

      if @post.save
        flash[:notice] = "Post was saved"
      else
        flash[:error] = "There was an error saving your post. Please try again"
      end

      redirect_to @wiki
  end

  def post_params
    params.require(:post).permit(
      :body
      )
  end
end
