class Public::RelationshipsController < ApplicationController
  layout 'public/application'
  before_action :authenticate_member!

  def create
    following = current_member.relationships.build(follower_id: params[:member_id])
    following.save
    @member = Member.find(params[:member_id])
  end

  def destroy
    following = current_member.relationships.find_by(follower_id: params[:member_id])
    following.destroy
    @member = Member.find(params[:member_id])
  end
end
