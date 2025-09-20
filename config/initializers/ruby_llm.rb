RubyLLM.configure do |config|
  config.ollama_api_base = "http://localhost:11434/v1"
  # config.default_model = "gpt-4.1-nano"

  # Use the new association-based acts_as API (recommended)
  config.use_new_acts_as = true
end
