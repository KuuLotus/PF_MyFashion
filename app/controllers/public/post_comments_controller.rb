class Public::PostCommentsController < ApplicationController
  layout 'public/application'
  before_action :authenticate_member!

  def create
    @post = Post.find(params[:post_id])
    @post_comment_new = current_member.post_comments.new(post_comment_params)
    @post_comment_new.post_id = @post.id
    @post_comment_new.save
  end

  def destroy
    @post = Post.find(params[:post_id])
    PostComment.find(params[:id]).destroy
  end

  private
   def post_comment_params
     params.require(:post_comment).permit(:comment)
   end
end
