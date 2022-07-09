class QuestionsController < ApplicationController
  def index
    @q = Question.ransack(params[:q])
    @questions = @q.result(distinct: true).page(params[:page]).per(10)
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.build(question_params) #associationを使って初期化する時はbuild
    if @question.save
      receivers = User.where.not(id: @question.user_id)
      receivers.each do |receiver|
        QuestionMailer.notice_email(receiver: receiver, question: @question).deliver_now
      end
      redirect_to question_path(@question), success: '質問を作成しました'
    else
      flash.now[:danger] = '失敗しました'
      render :new
    end
  end

  def edit
    @question = current_user.questions.find(params[:id])
  end

  def update
    @question = current_user.questions.find(params[:id])
    if @question.update(question_params)
      redirect_to question_path(@question), success: '質問を更新しました'
    else
      flash.now[:danger] = '失敗しました'
      render :edit
    end
  end

  def destroy
    @question = current_user.questions.find(params[:id])
    @question.destroy!
    redirect_to questions_path
  end

  def solved
    @q = Question.ransack(params[:q])
    @questions = @q.result(distinct: true).where(solved: true).page(params[:page]).per(10)
    render :index
  end

  def unsolved
    @q = Question.ransack(params[:q])
    @questions = @q.result(distinct: true).where(solved: false).page(params[:page]).per(10)
    render :index
  end

  def solve
    @question = current_user.questions.find(params[:id])
    @question.update!(solved: true)
    redirect_to question_path(@question), success: '解決済みにしました'
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
