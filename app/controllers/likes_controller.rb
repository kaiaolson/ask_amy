class LikesController < ApplicationController
  before_action :authenticate_user

  def create
    question = Question.find params[:question_id]
    like = Like.new(question: question, user: current_user)
    if like.save
      redirect_to question, notice: "Liked!"
    else
      redirect_to question, alert: "Not Liked!"
    end
  end

  def destroy
    question = Question.find params[:question_id]
    like = current_user.likes.find params[:id]
    like.destroy
    redirect_to question, notice: "Unliked!"
  end
end
