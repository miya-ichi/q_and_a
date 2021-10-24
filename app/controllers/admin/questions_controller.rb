class Admin::QuestionsController < ApplicationController
  def index
    @q = Question.ransack(params[:q])
    @questions = @q.result(distinct: true).recent.page(params[:page]).per(10)
  end

  def show
    @question = Question.find(params[:id])
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    redirect_to admin_questions_path, notice: "質問「#{@question.title}」を削除しました。"
  end
end
