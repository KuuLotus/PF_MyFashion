class Public::HomesController < ApplicationController
  def top
    @posts = Post.joins(:member).where({member: {is_deleted: false}}).page(params[:page]).per(40)
  end

  def men
    @posts_men = Post.joins(:member).where({member: {is_deleted: false}}).where({member: {gender: 0}}).page(params[:page]).per(40)
  end

  def women
    @posts_women = Post.joins(:member).where({member: {is_deleted: false}}).where({member: {gender: 1}}).page(params[:page]).per(40)
  end

end
