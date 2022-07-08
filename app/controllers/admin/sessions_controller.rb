class Admin::SessionsController < Admin::BaseController

  def new; end

  def create
    user = User.find_by(email: params[:email])
    if user.present? && user.authenticate(params[:password]) && user.admin?
      session[:admin_id] = user.id
      redirect_to admin_questions_path
    else
      session[:admin_id] = nil
      redirect_to admin_login_path, danger: '管理画面にログインできませんでした'
    end
  end
end
