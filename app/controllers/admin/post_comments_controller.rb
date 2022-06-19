class Admin::PostCommentsController < ApplicationController
  layout 'admin/application'
  before_action :authenticate_admin!
  
  def destroy
    @post = Post.find(params[:post_id])
    PostComment.find(params[:id]).destroy
  end
end
