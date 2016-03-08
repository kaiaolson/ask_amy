class Api::V1::QuestionsController < Api::BaseController

  def index
    @questions = Question.order("created_at DESC").limit(10)
    render json: @questions
  end

  def show
    @question = Question.find params[:id]
    render json: @question
  end

  def create
    question_params = params.require(:question).permit(:title, :body)
    @question = Question.new question_params
    @question.user = @user
    if @question.save
      head :ok
    else
      render json: { errors: @question.errors.full_messages }
    end
  end
end
