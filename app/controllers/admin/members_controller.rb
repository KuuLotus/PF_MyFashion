class Admin::MembersController < ApplicationController
  layout 'admin/application'
  before_action :authenticate_admin!

  def index
    @members = Member.page(params[:page]).per(30)
  end

  def show
    @member = Member.find(params[:id])
    @member_posts = @member.posts.page(params[:page]).per(20)
  end

  # 論理削除
  def withdraw
    @member = Member.find(params[:id])
    @member.update(is_deleted: true)
    flash[:notice] = "退会させました"
    redirect_to admin_root_path
  end

  def followings
    @member = Member.find(params[:id])
    @members = @member.followings.page(params[:page]).per(40)
  end

  def followers
    @member = Member.find(params[:id])
    @members = @member.followers.page(params[:page]).per(40)
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
  end
end
