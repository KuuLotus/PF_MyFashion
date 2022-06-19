class Admin::TagsController < ApplicationController
  layout 'admin/application'
  before_action :authenticate_admin!

  def index
    @tags = Tag.page(params[:page]).per(40)
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    @tags = Tag.page(params[:page]).per(40)
    if @tag.save
      flash[:notice] = "タグを追加しました"
    else
      flash[:alert] = "タグを追加できませんでした"
      render :index
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    flash[:notice] = "タグを削除しました"
    redirect_to admin_tags_path
  end

  private
    def tag_params
      params.require(:tag).permit(:name)
    end
end
