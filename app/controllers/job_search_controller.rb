class JobSearchController < ApplicationController
  def list
    total_jobs = []

    q = params[:q] || "ruby"
    location = params[:location] || "United States"


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

    @jobs = total_jobs.uniq { |job| job[:job_id] }
    jobs_matter_id = JobApplication.where(user: current_user).pluck(:job_id).uniq
    jobs_matter = Job.where(id: jobs_matter_id)
    @job_external_ids = jobs_matter.where(source: 'serpapi').pluck(:external_job_id)
  rescue StandardError => e
    @jobs = []
  end
end
