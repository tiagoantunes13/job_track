class JobSearchController < ApplicationController
  include ApplicationHelper
  def list
    total_jobs = []

    q = params[:q].presence || "ruby"
    location = params[:location].presence || "United States"
    puts "Searching for jobs with query: #{q} in location: #{location}"


    client = SerpApi::Client.new(
      engine: "google_jobs",
      q: q,
      hl: "en",
      api_key: "b0e398e2656330e190767422ffde9a046d13ced4dc3cb360fc724d5ca3652d64",
      location: location,
    )

    results = client.search || []
    total_jobs.concat(results[:jobs_results])
    n = 0

    while n < 1
      n += 1
      # break if results[:serpapi_pagination] && results[:serpapi_pagination][:next_page_token].nil?
      client = SerpApi::Client.new(
        engine: "google_jobs",
        q: q,
        hl: "en",
        api_key: "b0e398e2656330e190767422ffde9a046d13ced4dc3cb360fc724d5ca3652d64",
        location: location,
        # next_page_token: results[:serpapi_pagination]&[:next_page_token] || nil
      )
      results = client.search || []
      total_jobs.concat(results[:jobs_results])
    end

    rejected_jobs = IgnoredJob.where(user: current_user).pluck(:external_job_id)
    @jobs = total_jobs.reject{|job| rejected_jobs.include?(job[:job_id])}.uniq { |job| job[:job_id] }
    jobs_matter_id = JobApplication.where(user: current_user).pluck(:job_id).uniq
    jobs_matter = Job.where(id: jobs_matter_id)
    @job_external_ids = jobs_matter.where(source: 'serpapi').pluck(:external_job_id)
  rescue StandardError => e
    puts "Error fetching jobs: #{e.message}"
    @jobs = []
  end

  def ignore_job
    external_job_id = params[:external_job_id]
    source = params[:source] || 'serpapi'
    reason = params[:reason] || 'No reason provided'

    ignored_job = IgnoredJob.new(
      external_job_id: external_job_id,
      source: source,
      reason: reason,
      user: current_user
    )
    puts "REMOVING #{dom_id_for_json(external_job_id)}"
    if ignored_job.save
      respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.remove(dom_id_for_json(external_job_id))
      end
      format.html { redirect_to job_search_list_path, notice: "Job ignored successfully.", status: :see_other }
    end
    else
      redirect_to job_search_list_path, alert: "Failed to ignore job: #{ignored_job.errors.full_messages.join(', ')}", status: :see_other
    end
  end
end
