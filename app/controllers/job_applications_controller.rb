class JobApplicationsController < ApplicationController
  before_action :set_job_application, only: %i[ show edit update destroy generate_cover_letter ]
  before_action :authenticate_user!, except: %i[ index ]

  # GET /job_applications
  def index
    @job_applications = current_user.job_applications.order(updated_at: :desc)
  end

  # GET /job_applications/1
  def show
  end

  # GET /job_applications/new
  def new
    @job_application = JobApplication.new
  end

  # GET /job_applications/1/edit
  def edit
  end

  # POST /job_applications
  def create
    @job_application = JobApplication.new(job_application_params)
    @job_application.user = current_user

    if @job_application.save
      redirect_to @job_application, notice: "Job application was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /job_applications/1
  def update
    if @job_application.update(job_application_params)
      redirect_to @job_application, notice: "Job application was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /job_applications/1
  def destroy
    @job_application.destroy!
    redirect_to job_applications_path, notice: "Job application was successfully destroyed.", status: :see_other
  end

  def generate_cover_letter
    RubyLLM.configure { |c| c.openai_api_base = "http://localhost:11434/v1" }
    chat = RubyLLM.chat(model: "llama2", provider: :ollama, assume_model_exists: true)
    response = chat.ask(@job_application.generate_cover_letter)

    @job_application.cover_letter = response.content
    # @generated_letter = response.content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job_application
      @job_application = JobApplication.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def job_application_params
      params.require(:job_application).permit(:company, :position, :post, :status, :notes, :application_date, :job_posting_url, :contact_person, :expectations, :cover_letter, :location)
    end
end
