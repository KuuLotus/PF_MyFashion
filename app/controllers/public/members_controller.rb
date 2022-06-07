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
  
  private
   def member_params
     params.require(:member).permit(:name, :body, :height, :gender, :email, :profile_image)
   end
end
