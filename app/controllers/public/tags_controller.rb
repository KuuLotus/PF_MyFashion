class Public::TagsController < ApplicationController

  def tag_posts
    @tag = Tag.find(params[:id])
    @tags = Tag.limit(10)
    @tag_posts = @tag.posts.joins(:member).where({member: {is_deleted: false}}).page(params[:page]).per(30)
  end

end
