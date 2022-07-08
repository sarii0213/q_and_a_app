class QuestionMailer < ApplicationMailer
  default to: -> { User.where('id != ?', @question.user_id).pluck(:email) }

  def notice_email(question)
    @question = question
    mail(
      subject: '質問新規通知'
    )
  end
end
