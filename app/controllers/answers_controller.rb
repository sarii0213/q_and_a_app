class AnswersController < ApplicationController

  def create
    @answer = current_user.answers.build(answer_params.merge(question_id: params[:question_id]))
    if @answer.save
      @question = @answer.question
      other_answers_users = @question.answers.map(&:user_id)
      receivers = User.where(id: @question.user_id).or(User.where(id: other_answers_users)).where.not(id: @answer.user_id)
      receivers.each do |receiver|
        AnswerMailer.notice_email(receiver: receiver, answer: @answer).deliver_now
      end
      redirect_to question_path(params[:question_id]), success: '回答しました'
    else
      redirect_to question_path(params[:question_id])
    end
  end

  def destroy
    @answer = current_user.answers.find(params[:id])
    @answer.destroy!
    redirect_to question_path(params[:question_id]), notice: '回答を削除しました'
  end

  private
  def answer_params
    params.require(:answer).permit(:body)
  end
end
