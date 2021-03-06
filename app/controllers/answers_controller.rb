class AnswersController < ApplicationController
  def create
    @question          = Question.find params[:question_id]
    answer_params     = params.require(:answer).permit(:body)
    @answer           = Answer.new answer_params
    @answer.question  = @question
    if @answer.save
      redirect_to question_path(@question), notice: 'Answer created!'
    else
      render 'questions/show'
    end
  end

  def destroy
    question = Question.find params[:question_id]
    answer = Answer.find params[:id]
    answer.destroy
    redirect_to question_path(question), notice: 'Answer deleted!'
  end
end
