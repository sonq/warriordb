# app/controllers/admin/base_controller.rb
class Admin::BaseController < ApplicationController
  before_action :authenticate
  before_action :require_admin
  
  private
  
  def require_admin
    unless current_user&.admin?
      redirect_to root_path, alert: 'Bu sayfaya erişim yetkiniz yok.'
    end
  end
end