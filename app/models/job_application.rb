class JobApplication < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :job

  validates :company, presence: true
  validates :position, presence: true

  enum :status, { applied: 0, interviewing: 1, offered: 2, rejected: 3, accepted: 4 }
  enum :expectations, { low: 0, medium: 1, high: 2 }


  PROMPT = <<~PROMPT
    Write a professional cover letter for the following job posting and personal profile.

    Job Posting:
    {JOB_POST_TEXT}

    Personal Profile (JSON):
    {PROFILE_JSON}

    Instructions:
    1. Use the information in the JSON to highlight your most relevant skills, achievements, and experience.
    2. Map those points directly to the requirements and responsibilities listed in the job posting.
    3. Keep the letter concise (≈200-250 words) and structured with an opening, body, and closing paragraph.
    4. Use a confident yet genuine tone, ending with a call to action (e.g., “I look forward to discussing how I can contribute…”) and your contact details.
    5. It should not at any moment look like AI made content. It should be 100% human sounding and genuine, maybe even with a few minor imperfections and looking excited about the role. (THIS IS THE MOST IMPORTANT ASPECT).

    Please output the cover letter in plain text, no extra formatting or code blocks.
  PROMPT

  def generate_cover_letter
    PROMPT.gsub("{JOB_POST_TEXT}", self.post).gsub("{PROFILE_JSON}", user.profile_json)
  end

  def position
    job.title
  end

  def company
    job.company
  end

  def location
    job.location
  end
end
