class QuestionsController < ApplicationController
  #before_action :authenticate_employee!

  def index
    questions = Question.where(anonymous: true)
      #authorize questions
    render json: questions, status: 200
  end

  def show
    question = Question.find(params[:id])
      #authorize question
    render json: question, status: 200
  end

  def create
    question = Question.new(question_params)
    #authorize question
    if question.save
      render json: question, status: 200
    else
      render json: {message: "Question Cannot be created", error: question.errors.full_messages}
    end
  end

  def update
    question = Question.find(params[:id])
      #authorize question
    if question.update(updated_question_params)
      render json: question, status: 200
    else
      render json: {message: "Question cannot be updated", error: question.errors.full_messages}
    end
  end

  def destroy
    question = Question.find(params[:id])
    #authorize question
    question.destroy
    render json: {message: "Record Destroyed Successfully"}
  end

  # def replies
  #   question = Question.find(params[:id])
  #   replies = question.answers
  #   render json: replies, status: 200
  # end

  def query_answer
    answer = Question.find(params[:id])
    # authorize answer
    if answer.update(answer_params)
      render json: answer, status: 200
    else
      render json: {message: "Question cannot be updated", error: answer.errors.full_messages}
    end
  end

  def answer_opinion
    opinion = Question.find(params[:id])
    # authorize opinion
    if opinion.update(opinion_params)
      render json: opinion, status: 200
    else
      render json: {message: "Question cannot be updated", error: opinion.errors.full_messages}
    end
  end


  private

  
  def question_params
    params.require(:question).permit(:query, :employee_id, :manager_id, :anonymous)
  end

  def updated_question_params
    params.require(:question).permit(:query, :clarified, :remarks)
  end

  def answer_params
    params.require(:question).permit(:answer)
  end  
  
  def opinion_params
    params.require(:question).permit(:opinion, :anonymous)
  end  

end
