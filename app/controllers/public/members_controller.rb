class Public::MembersController < ApplicationController
  def index
    @members = Member.where.not(id: current_member.id)
  end

  def show
    @member = Member.find(params[:id])
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
    member = Member.find(params[:id])
    @members = member.followings
  end

  def followers
    member = Member.find(params[:id])
    @members = member.followers
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

  private
   def member_params
     params.require(:member).permit(:name, :body, :height, :gender, :email, :profile_image)
   end
end
