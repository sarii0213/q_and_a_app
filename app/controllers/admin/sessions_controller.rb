class Admin::SessionsController < Admin::BaseController
  def new; end

  def create
    user = User.find_by(email: params[:email])
    if user.present? && user.authenticate(params[:password])
      session[:admin_id] = user.id
      redirect_to new_user_path
    else
      render :new
    end
  end
end
