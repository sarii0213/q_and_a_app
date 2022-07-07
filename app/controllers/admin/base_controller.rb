class Admin::BaseController < ApplicationController
  layout 'admin/layouts/application'
  before_action :require_admin

  private

  def require_admin
    redirect_to questions_path, danger: '管理画面には入れません' unless current_user&.admin?
  end
end
