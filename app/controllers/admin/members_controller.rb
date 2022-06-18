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
end
