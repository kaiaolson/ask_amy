class Api::V1::QuestionsController < ApplicationController

  def index
    @questions = Question.order("created_at DESC").limit(10)
    render json: @questions
  end

  def show
    @question = Question.find params[:id]
    render json: @question
  end
end
