class Admin::PostsController < ApplicationController
  layout 'admin/application'
  before_action :authenticate_admin!

  def index
    @posts = Post.order(id: :desc).page(params[:page]).per(40)
  end

  # いいねが多い順
  def many_favorites
    posts = Post.includes(:favorited_members).sort {|a,b| b.favorited_members.size <=> a.favorited_members.size}
    @posts = Kaminari.paginate_array(posts).page(params[:page]).per(40)
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "削除しました"
    redirect_to admin_posts_path
  end

  # 男性の投稿
  def men
    @posts_men = Post.joins(:member).where({member: {gender: 0}}).order(id: :desc).page(params[:page]).per(40)
  end

  # 女性の投稿
  def women
    @posts_women = Post.joins(:member).where({member: {gender: 1 }}).order(id: :desc).page(params[:page]).per(40)
  end

  def search
    @tags = Tag.limit(10)
  end
end
