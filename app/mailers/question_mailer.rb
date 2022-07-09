class QuestionMailer < ApplicationMailer
  # default to: -> { User.where('id != ?', @question.user_id).pluck(:email) }
  # default to: -> { User.where.not(id: @question.user_id).pluck(:email) }
  def notice_email(receiver:, question: )
    @question = question
    mail(
      subject: '質問新規通知',
      to: receiver.email,
    )
  end
end
