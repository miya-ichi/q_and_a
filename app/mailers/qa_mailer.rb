class QaMailer < ApplicationMailer
  def creation_email(question)
    @question = question
    mail_to = User.pluck(:email)
    mail_to.delete(@question.user.email)
    mail(
      subject: '質問が投稿されました',
      to: mail_to,
      from: 'qa_app@example.com'
    )
  end

  def answer_email(answer)
    @answer = answer
    mail_to = User.pluck(:email)
    mail_to.delete(@answer.user.email)
    mail(
      subject: '質問に回答がありました',
      to: mail_to,
      from: 'qa_app@example.com'
    )
  end
end
