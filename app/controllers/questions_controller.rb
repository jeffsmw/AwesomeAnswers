class QuestionsController < ApplicationController
  # the 'before_action' method in here registers a method (usually private) to be
  # executed just before controller actions. This happens within the same
  # request/response cycle which means if you define an instance variable it will
  # be available  within the action
  # You can optionally give options: 'only' or 'except' to restrict the actions
  # that this 'before_action' method applies to.
  before_action :find_question, only: [:edit, :update, :destroy, :show]
  before_action :authenticate_user, except: [:index, :show]
  #this action is to show the form for creating a new question
  #the url: /questions/new
  #the path helper is new_question_path
  def new
    @question = Question.new
  end

  #this action is to handle creating a new question after submitting the form that was shown in the new action
  def create
    #allows only title and body parameters

    @question = Question.new question_params
    @question.user = current_user
    if @question.save
      # redirect_to question_path({id: @question.id})
      # redirect_to question_path({id: @question})

      #flash works very similartto the sessino in a swense that it uses cookies
      # to store values that persist through redirect_to or render
      # flash will clear the value as soon as it's read so it doesn't persist
      #through the rest of the requests
      flash.now[:notice] = 'Question Created!'
      redirect_to question_path(@question)
    else
      # render plain: "Question Not Created!"
      # IF we just use flash[:alert] in here then the flash message will persist
      # to the next request as well. falsh.now[:alert] will make it only show
      # when you render the ':new' template but it won't persist to the next
      #request
      flash.now[:alert] = 'See errors below'
      render :new
    end
  end

  # this action is to show information about a specific question
  #URL: /question/:id (for example /questions/123)
  # METHOD: GET
  def show
    # render plain: "In show action"
    @answer = Answer.new
  end

  # this action is to show a listings of all the questions
  # URL: /questions
  # METHOD: GET
  def index
    @question = Question.order(created_at: :desc)
  end


  # this action is to show a form pre-populated with the question's data
  # URL: /questions/:id/edit
  # METHOD: GET
  def edit
  end

  # this action is to capture the parameters from the form submission for the
  # edit action in order to update a question
  # URL: /questions/:id
  # METHOD: PATCH
  def update
    if @question.update question_params
      flash.now[:notice] = 'Question updated'
      redirect_to question_path(@question)
    else
      flash.now[:alert] = 'Please see errors below!'
      render :edit
    end
  end

  #this action handles deleteing a question
  #URL: /questions/:id
  #METHOD: DELETE
  def destroy
    @question.destroy
    #adding 'notice:' to the redirect_to line will set a
    #flash notice message as we did the create / update actions
    # note that this only works for redirect and not for render
    redirect_to questions_path, notice: 'Question deleted'
  end

  private

  def question_params
    params.require(:question).permit([:title, :body])
  end

  def find_question
    @question = Question.find params[:id]
  end

end
