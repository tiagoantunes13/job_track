class RemoteAnalysesController < ApplicationController

  before_action :authenticate_user!

  # GET /remote_analyses/new
  def new
  end

  # POST /remote_analyses

  def create
    RubyLLM.configure { |c| c.openai_api_base = "http://localhost:11434/v1" }
    chat = RubyLLM.chat(model: "llama2", provider: :ollama, assume_model_exists: true)
    @response = chat.with_schema(Schema::AnalysisSchema).ask(generate_prompt(params[:job_text])).content
  end

  private

  def generate_prompt(job_post)
    "Based on the following job posting, tell me if this is a remote job or not. Answer only with 'remote' or 'not remote'. Here is the job posting: #{job_post}.\n If the job posting does not specify if it's remote or not, or if is something more complicated, answer 'unsure'."
  end
end
