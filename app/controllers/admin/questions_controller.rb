class Admin::QuestionsController < Admin::BaseController
  before_action :require_admin

  def index
    @questions = Question.all
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy!
    redirect_to admin_questions_path
  end

  private

  def require_admin
    redirect_to admin_login_path, danger: '管理画面には入れません' unless session[:admin_id]
  end
end
