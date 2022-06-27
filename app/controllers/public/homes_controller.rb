class Public::HomesController < ApplicationController
  layout 'public/application'
  def top
    @posts = Post.joins(:member).where({member: {is_deleted: false}}).order(id: :desc).page(params[:page]).per(40)
    @tags = Tag.limit(10)
  end

  def men
    @posts = Post.joins(:member).where({member: {is_deleted: false}}).where({member: {gender: 0}}).order(id: :desc).page(params[:page]).per(40)
    @tags = Tag.limit(10)
  end

  def women
    @posts = Post.joins(:member).where({member: {is_deleted: false}}).where({member: {gender: 1}}).order(id: :desc).page(params[:page]).per(40)
    @tags = Tag.limit(10)
  end

end
