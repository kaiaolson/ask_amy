class LikesController < ApplicationController
  before_action :authenticate_user

  def create
    @question = Question.find params[:question_id]
    @like = Like.new(question: @question, user: current_user)
    respond_to do |format|
      if @like.save
        format.html { redirect_to @question, notice: "Liked!" }
        format.js { render :successfully_liked }
      else
        format.html { redirect_to @question, alert: "Not Liked!" }
        format.js { render :unsuccessfully_liked }
      end
    end
  end

  def destroy
    @question = Question.find params[:question_id]
    @like = current_user.likes.find params[:id]
    @like.destroy
    respond_to do |format|
      format.html { redirect_to @question, notice: "Unliked!" }
      format.js   { render }
    end
  end
end
