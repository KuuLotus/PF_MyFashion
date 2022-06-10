class ApplicationController < ActionController::Base
  before_action :set_search

  def set_search
    @q = Member.ransack(params[:q])
    @search_members = @q.result(distinct: true)
  end
end
