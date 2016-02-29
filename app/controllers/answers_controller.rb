class AnswersController < ApplicationController
  before_action :find_answer, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, except: [:index, :show]
  before_action :authorize_user, only: [:edit, :update, :destroy]

  def create
    @question = Question.find params[:question_id]
    @answer = Answer.new answer_params
    @answer.question = @question
    @answer.user = current_user
    respond_to do |format|
      if @answer.save
        # AnswersMailer.notify_question_owner(@answer).deliver_later
        # indicates what to do if in html format
        format.html { redirect_to question_path(@question), notice: "Answer created!" }
        # indicates what to do if in js format
        format.js   { render :create_success }
      else
        format.html { render "/questions/show", alert: "Answer not created!" }
        format.js   { render :create_failure }
      end
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
    respond_to do |format|
      format.html { redirect_to question_path(params[:question_id]), notice: "Answer deleted!"}
      format.js { render } # this renders app/views/answers/destroy.js.erb
    end
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
