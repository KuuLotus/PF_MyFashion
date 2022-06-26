class Admin::MembersController < ApplicationController
  layout 'admin/application'
  before_action :authenticate_admin!

  def index
    @members = Member.page(params[:page]).per(30)
  end

  def show
    @member = Member.find(params[:id])
    @member_posts = @member.posts.page(params[:page]).per(20)
    @member_followings = @member.followings.where.not(is_deleted: true).page(params[:page]).per(40)
    @member_followers = @member.followers.where.not(is_deleted: true).page(params[:page]).per(40)
  end

  # 論理削除
  def withdraw
    @member = Member.find(params[:id])
    if @member.is_deleted == false
      @member.update(is_deleted: true)
      flash[:notice] = "退会させました"
      redirect_to admin_root_path
    else
      @member.update(is_deleted: false)
      flash[:notice] = "入会中にさせました"
      redirect_to admin_root_path
    end
  end

  def followings
    @member = Member.find(params[:id])
    @members = @member.followings.page(params[:page]).per(40)
    @member_followings = @member.followings.where.not(is_deleted: true).page(params[:page]).per(40)
    @member_followers = @member.followers.where.not(is_deleted: true).page(params[:page]).per(40)
  end

  def followers
    @member = Member.find(params[:id])
    @members = @member.followers.page(params[:page]).per(40)
    @member_followings = @member.followings.where.not(is_deleted: true).page(params[:page]).per(40)
    @member_followers = @member.followers.where.not(is_deleted: true).page(params[:page]).per(40)
  end

  # 男性ユーザー
  def men
    @members_men = Member.where(gender: 0).page(params[:page]).per(30)
  end

  # 女性ユーザー
  def women
    @members_women = Member.where(gender: 1).page(params[:page]).per(30)
  end

  # 検索結果
  def search
    @q = Member.ransack(params[:q])
    @search_members = @q.result(distinct: true).page(params[:page]).per(30)
  end

  def favorites
    @member = Member.find(params[:id])
    favorites = Favorite.where(member_id: @member.id).order(created_at: :desc).pluck(:post_id)
    @favorites = Post.find(favorites)
    @member_followings = @member.followings.where.not(is_deleted: true).page(params[:page]).per(40)
    @member_followers = @member.followers.where.not(is_deleted: true).page(params[:page]).per(40)
  end
end
