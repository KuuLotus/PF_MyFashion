class Admin::PostsController < ApplicationController
  layout 'admin/application'
  before_action :authenticate_admin!

  def index
    @posts = Post.page(params[:page]).per(40)
    @tags = Tag.limit(10)
  end

  def show
    @post = Post.find(params[:id])
  end
end
