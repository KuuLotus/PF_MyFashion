class Public::MembersController < ApplicationController
  before_action :ensure_corect_member, only:[:edit, :withdraw_confirm]
  before_action :ensure_guest_user, only:[:edit, :withdraw_confirm]
  before_action :ensure_withdraw_member, only:[:show, :followings, :followers]

  def index
    @members = Member.where.not(is_deleted: true).where.not(id: current_member.id).page(params[:page]).per(30)
  end

  def show
    @member = Member.find(params[:id])
    @member_posts = @member.posts.page(params[:page]).per(20)
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    if @member.update(member_params)
      flash[:notice] = "ユーザー情報を変更しました"
      redirect_to member_path(@member)
    else
      flash[:alert] = "ユーザー情報の変更に失敗しました"
      render :edit
    end
  end

  def followings
    @member = Member.find(params[:id])
    @members = @member.followings.page(params[:page]).per(40)
  end

  def followers
    @member = Member.find(params[:id])
    @members = @member.followers.page(params[:page]).per(40)
  end

  # 退会確認画面
  def withdraw_confirm
    @member = Member.find(params[:id])
  end

  # 論理削除
  def withdraw
    @member = Member.find(params[:id])
    @member.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会しました"
    redirect_to root_path
  end

  # 検索結果
  def search
  end

  # 男性ユーザー
  def men
    @members_men = Member.where.not(is_deleted: true).where.not(id: current_member.id).where(gender: 0).page(params[:page]).per(30)
  end

  # 女性ユーザー
  def women
    @members_women = Member.where.not(is_deleted: true).where.not(id: current_member.id).where(gender: 1).page(params[:page]).per(30)
  end

  private
    def member_params
      params.require(:member).permit(:name, :body, :height, :gender, :email, :profile_image)
    end

    def ensure_corect_member
      @member = Member.find(params[:id])
      unless @member == current_member
        flash[:alert] = "不正なアクセスです"
        redirect_to members_path
      end
    end

    def ensure_withdraw_member
      member = Member.find(params[:id])
      if member.is_deleted == true
        flash[:alert] = "退会済みユーザーです"
        redirect_to members_path
      end
    end

    def ensure_guest_user
      @member = Member.find(params[:id])
      if @member.name == "企業様(閲覧用)"
        redirect_to member_path(current_member) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
      end
    end
end
