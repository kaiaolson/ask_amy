class QuestionsController < ApplicationController
  # runs find_question before any action so we don't have to find the question over and over
  before_action :find_question, only: [:show, :edit, :update, :destroy]

  before_action :authenticate_user, except: [:index, :show]

  before_action :authorize_user, only: [:edit, :update, :destroy]

  def new
    @question = Question.new
    # can set default values here that will show up automatically in the form - good for repopulating fields
  end

  def create
    # using params.require ensures that there is a key called question in my params; the permit method will only allow parameters that you explicitly list; in this case, title and body
    @question = Question.new question_params
    @question.user = current_user
    if @question.save
      redirect_to question_path(@question)
    else
      # this will render app/views/questions/new.html.erb template
      # we need to be explicit about rendering the new template because the default behavior is to render 'create.html.erb'
      render :new
    end
  end

  def show
    @question.view_count += 1
    @question.save
    @answer = Answer.new
    @answers = @question.answers
    respond_to do |format|
      format.html { render }
      format.json { render json: @question }
    end
  end

  def index
    @questions = Question.all
    respond_to do |format|
      format.html { render }
      format.json { render json: @questions.select(:id, :title, :view_count) }
    end
  end

  def edit
  end

  def update
    if @question.update question_params
      redirect_to question_path(@question)
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path
  end

  private

  def question_params
    params.require(:question).permit(:title, :body, :category_id, {tag_ids: []})
  end

  def find_question
    @question = Question.find params[:id]
  end

  def authorize_user
    unless can? :manage, @question
      redirect_to root_path, alert: "access denied!"
    end
  end
end
