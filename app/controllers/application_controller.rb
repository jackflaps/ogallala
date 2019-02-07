class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

  def render_404
    flash[:error] = "Record not found"
    redirect_to :controller => :welcome, :action => :index
  end
end
