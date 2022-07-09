class Admin::UsersController < Admin::BaseController
  before_action :require_admin

  def index
    @users = User.all
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy!
    redirect_to admin_users_path, notice: "ユーザー「#{@user.name}」を削除しました"
  end

  private

  def require_admin
    redirect_to admin_login_path, danger: '管理画面には入れません' unless session[:admin_id]
  end

end
