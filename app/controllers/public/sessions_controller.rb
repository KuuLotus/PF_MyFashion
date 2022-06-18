# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  layout 'public/application'
  before_action :reject_member, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  def guest_sign_in
    member = Member.guest
    sign_in member
    redirect_to member_path(member), notice: '企業様(閲覧用)でログインしました。'
  end

  protected

  def reject_member
    @member = Member.find_by(email: params[:member][:email])
    if @member
      if @member.valid_password?(params[:member][:password]) && (@member.is_deleted == true)
        flash[:notice] = "退会済みです。再度ご登録をしてご利用ください。"
        redirect_to new_member_registration_path
      end
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
