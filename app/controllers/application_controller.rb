class ApplicationController < ActionController::Base
  before_action :set_search

  def set_search
    if params["admin"].present?
      @q = Member.ransack(params[:q])
      @search_members = @q.result(distinct: true).page(params[:page]).per(30)
      @search_post = Post.ransack(params[:q])
      @search_posts = @search_post.result(distinct: true).page(params[:page]).per(40)
    else
      @q = Member.ransack(params[:q])
      @search_members = @q.result(distinct: true).where.not(is_deleted: true).page(params[:page]).per(30)
      @search_post = Post.ransack(params[:q])
      @search_posts = @search_post.result(distinct: true).page(params[:page]).per(40)
    end
  end
end
