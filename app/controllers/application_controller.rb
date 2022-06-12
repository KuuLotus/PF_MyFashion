class ApplicationController < ActionController::Base
  before_action :set_search

  def set_search
    @q = Member.ransack(params[:q])
    @search_members = @q.result(distinct: true).where.not(is_deleted: true)
    @search_post = Post.ransack(params[:q])
    @search_posts = @search_post.result(distinct: true)
  end

end
