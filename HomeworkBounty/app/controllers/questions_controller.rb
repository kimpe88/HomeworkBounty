class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
	before_filter :authenticate_user!, :except => [:tags, :index, :show]
	load_and_authorize_resource param_method: :question_params, :except => [:tags,:search]
	include QuestionsHelper


  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
		author = User.find(current_user.username)
		@question = author.questions_made.new(question_params)
    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url }
      format.json { head :no_content }
    end
  end
	
	#Display /questions/tags
	def tags
		@question = Question.with_all_taglist(params[:tag_list])
	end
	
	#Display search on questions/search/
	def search
		if ( !params[:category]['question_category'].blank? &&  !params[:taglist].blank?)
			@tmp_question = Category.find(params[:category]['question_category']).questions_under_category
			@question =  @tmp_question.with_all_taglist(params[:taglist])
		elsif (!params[:taglist].blank?)
			@question =  Question.with_all_taglist(params[:taglist])
		elsif (!params[:category]['question_category'].blank?)
			@question = Category.find(params[:category]['question_category']).questions_under_category
		else	
			@question = Question.all
		end
	end
	
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
			params[:question].permit(:title, :body, :taglist, :question_category_id)
    end
end
