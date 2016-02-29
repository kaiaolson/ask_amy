class VotesController < ApplicationController
  before_action :authenticate_user

  def create
    question         = Question.find params[:question_id]
    vote             = Vote.new vote_params
    vote.user        = current_user
    vote.question    = question
    # dry
    vote.save ? (flash[:notice] = "You voted!") : (flash[:alert] = "Already voted!")
    redirect_to question
  end

  def update
    question = Question.find params[:question_id]
    vote = current_user.votes.find params[:id]
    vote.update vote_params
    redirect_to question, notice: "Vote updated!"
  end

  def destroy
    question = Question.find params[:question_id]
    vote     = current_user.votes.find params[:id]
    vote.destroy
    redirect_to question, notice: "Vote removed!"

  end

  private

  def vote_params
    params.require(:vote).permit(:is_up)
  end
end
