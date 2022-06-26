class Public::FavoritesController < ApplicationController
  layout 'public/application'
  before_action :authenticate_member!

  def create
    @post = Post.find(params[:post_id])
    favorite = current_member.favorites.new(post_id: @post.id)
    favorite.save
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_member.favorites.find_by(post_id: @post.id)
    favorite.destroy
  end
  
end
