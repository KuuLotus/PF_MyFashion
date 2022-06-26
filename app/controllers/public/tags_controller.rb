class Public::TagsController < ApplicationController
  layout 'public/application'

  def tag_posts
    @tag = Tag.find(params[:id])
    @tags = Tag.limit(10)
    @tag_posts = @tag.posts.joins(:member).where({member: {is_deleted: false}}).order(id: :desc).page(params[:page]).per(30)
  end

end
