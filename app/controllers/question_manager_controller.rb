class QuestionManagerController < ApplicationController

  def index
    @questions = Question.all
    @question = Question.new
    @index = "question_manager"

    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end
end