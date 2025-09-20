class RemoteAnalysesController < ApplicationController

  before_action :authenticate_user!

  # GET /remote_analyses/new
  def new
  end

  # POST /remote_analyses

  def create
    RubyLLM.configure { |c| c.openai_api_base = "http://localhost:11434/v1" }
    chat = RubyLLM.chat(model: "llama2", provider: :ollama, assume_model_exists: true)
    @response = chat.with_schema(AnalysisSchema).ask(generate_prompt(params[:job_post])).content
  end

  private

  def generate_prompt(job_post)
    prompt = <<~PROMPT
      Analyze the following job posting description to determine the work location type.

      Provide your analysis in two parts:
      1.  A **veridict** that must be one of the following four values: "remote", "onsite", "hybrid", or "unsure". If there is any doubt or ambiguity, default to "unsure".
      2.  An **explanation** justifying your veridict based on key phrases or details from the description.

      Use the following criteria for your verdict:
      -   **"remote"**: The job explicitly mentions it is fully remote, work-from-home, or location-independent.
      -   **"onsite"**: The job requires a physical presence, mentions a specific office location, or uses terms like "in-office" or "colocated."
      -   **"hybrid"**: The job requires a mix of in-office and remote work, with specific days or a ratio mentioned.
      -   **"unsure"**: The description provides no clear information about the work location type, **or if there is any doubt about the other categories**.

      ---
      Job Description:
      {{job_text}}
    PROMPT

    prompt.gsub("{{job_text}}", job_post)
  end
end
