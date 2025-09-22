RubyLLM.configure do |config|
  # config.ollama_api_base = "http://localhost:11434/v1"
  config.openai_api_key = Rails.application.credentials.open_ai_key
  # config.default_model = "gpt-4.1-nano"

  # Use the new association-based acts_as API (recommended)
  config.use_new_acts_as = true
end
