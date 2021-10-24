class AnswersController < ApplicationController
  skip_before_action :admin_required
  
  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params.merge(user_id: current_user.id))

    if @answer.save
      QaMailer.answer_email(@answer).deliver_now
      redirect_to question_path(@question), notice: '質問に回答しました。'
    else
      flash[:error] = '回答に失敗しました。'
      redirect_to question_path(@question)
    end
  end

  private

  def answer_params
    params.permit(:body)
  end
end
