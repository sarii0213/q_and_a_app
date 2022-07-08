class AnswerMailer < ApplicationMailer
  # default to: -> { User.where('id != ? AND (id == ? OR id == ?)', @answer.user_id, @question.user_id, @question.answers.user_id).pluck(:email) }
  # default to: -> { User.where('id != ?',@answer.user_id).where('id == ? OR id IN ?', @question.user_id, @other_answers_users).pluck(:email) }
  default to: -> { User.where(id: @question.user_id).or(User.where(id: @other_answers_users)).where.not(id: @answer.user_id).pluck(:email) }
  # 回答を投稿したユーザーでない AND 回答と紐づく質問をしたユーザー OR 回答と紐づく質問に回答したユーザー

  def notice_email(answer)
    @answer = answer
    @question = @answer.question
    @other_answers_users = @question.answers.pluck(:user_id)
    mail(
      subject: '回答新規通知'
    )
  end

end
