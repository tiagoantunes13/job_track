class JobsController < ApplicationController
  before_action :set_job, only: %i[ create show edit update ]

  def index
    @jobs = Job.all.order(created_at: :desc)
  end

  def new
    @job = Job.new
  end

  def create
    if @job.save
      redirect_to @job, notice: 'Job was successfully created.', status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @applied_by_user = current_user.job_applications.exists?(job_id: @job.id)
  end

  def edit
  end

  def update
    if @job.update(job_params)
      redirect_to @job, notice: 'Job was successfully updated.', status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def from_serpapi
    puts "Params: #{params.inspect}"
    puts "Job Params: #{params}"
    job_data = JSON.parse(params[:job], symbolize_names: true)

    @job = Job.new(
      title: job_data[:title],
      company: job_data[:company_name],
      location: job_data[:location],
      description: job_data[:description],
      job_posting_url: job_data[:job_posting_url],
      source: 'serpapi',
      external_job_id: job_data[:job_id],
    )

    job_data[:apply_options].each do |option|
      next if option[:link].blank? || option[:title].blank?
      @job.apply_links.build(
        url: option[:link],
        source: option[:title]
      )
    end

    if @job.save
      redirect_to @job, notice: 'Job was successfully created from SerpAPI.', status: :see_other
    else
      redirect_to job_search_list_path, alert: "Failed to save job: #{@job.errors.full_messages.join(', ')}", status: :see_other
    end
  end


  private

  def set_job
    @job = Job.find(params[:id])
  end

  def job_params
    params.require(:job).permit(:title, :company, :location, :job_posting_url, :description, :external_job_id, :source, :job_data, :company_details)
  end
end
