
class AnalysisSchema < RubyLLM::Schema
  string :veridict, enum: ["remote", "onsite", "hybrid", "unsure"], description: "Indicates if the job is remote, onsite, hybrid, or unsure"
  string :explanation, description: "A brief explanation of the veridict, why it is classified as such"
end