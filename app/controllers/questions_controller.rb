class QuestionsController < ApplicationController
  skip_before_action :login_required, only: [:index, :show]
  skip_before_action :admin_required

  def index
    @q = Question.ransack(params[:q])
    @questions = @q.result(distinct: true).recent.page(params[:page]).per(10)
  end

  def solved
    @q = Question.where(solved: true).ransack(params[:q])
    @questions = @q.result(distinct: true).recent.page(params[:page]).per(10)
    render :index
  end

  def unsolved
    @q = Question.where(solved: false).ransack(params[:q])
    @questions = @q.result(distinct: true).recent.page(params[:page]).per(10)
    render :index
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = current_user.questions.new
  end

  def create
    @question = current_user.questions.new(question_params)

    if @question.save
      QaMailer.creation_email(@question).deliver_now
      redirect_to questions_path, notice: "質問「#{@question.title}」を投稿しました。"
    else
      render :new
    end
  end

  def edit
    @question = current_user.questions.find(params[:id])
  end

  def update
    @question = current_user.questions.find(params[:id])

    if @question.update(question_params)
      redirect_to @question, notice: '質問を更新しました。'
    else
      render :edit
    end
  end

  def destroy
    @question = current_user.questions.find(params[:id])
    @question.destroy
    redirect_to root_url, notice: "質問「#{@question.title}」を削除しました。"
  end

  private

  def question_params
    params.require(:question).permit(:title, :body, :solved)
  end
end
