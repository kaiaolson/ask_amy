class AnswersController < ApplicationController
  before_action :find_answer, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, except: [:index, :show]
  before_action :authorize_user, only: [:edit, :update, :destroy]

  def create
    @question = Question.find params[:question_id]
    @answer = Answer.new answer_params
    @answer.question = @question
    @answer.user = current_user
    if @answer.save
      redirect_to question_path(@question), notice: "Answer created!"
    else
      render "/questions/show", alert: "Answer not created!"
    end
  end

  def edit
    @question = @answer.question
  end

  def update
    if @answer.update answer_params
      redirect_to question_path(@answer.question)
    else
      render :edit
    end
  end

  def destroy
    @answer.destroy
    redirect_to question_path(params[:question_id]), notice: "Answer deleted!"
  end

  private

  def find_answer
    @answer = Answer.find params[:id]
  end

  def answer_params
    params.require(:answer).permit(:body, :question_id, :user_id)
  end

  def authorize_user
    unless (can? :manage, @answer) || (can? :destroy, @answer)
      redirect_to root_path, alert: "access denied!"
    end
  end
end
