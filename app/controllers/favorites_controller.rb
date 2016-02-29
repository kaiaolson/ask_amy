class FavoritesController < ApplicationController
  before_action :authenticate_user

  def index
    @questions = current_user.favorite_questions
  end

  def create
    @question = Question.find params[:question_id]
    @favorite = Favorite.new(question: @question, user: current_user)
    respond_to do |format|
      if @favorite.save
        format.html { redirect_to @question, notice: "Question saved to favorites!" }
        format.js { render :successfully_favorited}
      else
        format.html { redirect_to @question, alert: "Question not saved to favorites!" }
        format.js { render :unsuccessfully_favorited}
      end
    end
  end

  def destroy
    session[:return_to] ||= request.referer
    @question = Question.find params[:question_id]
    @favorite = current_user.favorites.find params[:id]
    @favorite.destroy
    respond_to do |format|
      format.html { redirect_to session.delete(:return_to), alert: "Question deleted from favorites!" }
      format.js   { render }
    end
  end
end
