class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy,:accept_answer,:un_accept_answer]
	before_filter :authenticate_user!, :except => [:index, :show]
	load_and_authorize_resource param_method: :answer_params, :except => [:accept_answer,:un_accept_answer]

  # GET /answers
  # GET /answers.json
  def index
    @answers = Answer.all
  end

  # GET /answers/1
  # GET /answers/1.json
  def show
  end

  # GET /answers/new
  def new
    @answer = Answer.new
  end

  # GET /answers/1/edit
  def edit
  end

  # POST /answers
  # POST /answers.json
  def create
		@answer = Answer.new(answer_params)
  	begin
			user = current_user
			question = Question.find(answer_params[ :question ])
			question.answers << @answer
			user.answers_made << @answer
			respond_to do |format|
				if question.save and user.save
					format.html { redirect_to question_path(question), notice: 'Answer was successfully created.' }
					format.json { render :show, status: :created, location: @answer }
				else
					format.html { render :new }
					format.json { render json: @answer.errors, status: :unprocessable_entity }
				end
			end
			rescue Mongoid::Errors::DocumentNotFound => e
				flash[ :error ] = "Invalid question"
				redirect_to questions_path
		end
	end

  # PATCH/PUT /answers/1
  # PATCH/PUT /answers/1.json
  def update
    respond_to do |format|
      if @answer.update(:body => answer_params[:body])
        format.html { redirect_to @answer, notice: 'Answer was successfully updated.' }
        format.json { render :show, status: :ok, location: @answer }
      else
        format.html { render :edit }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to answers_url }
      format.json { head :no_content }
    end
  end
	
	def accept_answer
		respond_to do |format|
			if(current_user == @answer.question.author_to_question)
				@answer.update(:accepted => true)
				@answer.question.update(:answered => true)
				format.html { redirect_to question_path(@answer.question), notice: 'Answer was succesfully accepted.' }
				format.json { render :show, status: :updated, location: @answer }
			else
				format.html { redirect_to question_path(@answer.question), notice: 'You can not accept a answer to a question too which you are not the author ' }
				format.json { render :show, status: :update, location: @answer }
			end
		end
	end
	
	def un_accept_answer
		respond_to do |format|
			if(current_user == @answer.question.author_to_question)
				@answer.update(:accepted => false)
				@answer.question.update(:answered => false)
				format.html { redirect_to question_path(@answer.question), notice: 'Answer was succesfully un accepted.' }
				format.json { render :show, status: :updated, location: @answer }
			else
				format.html { redirect_to question_path(@answer.question), notice: 'You can not un accept a answer to a question too which you are not the author ' }
				format.json { render :show, status: :update, location: @answer }
			end
		end
	end
	
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
			params[:answer].permit(:body, :question)
    end
end
