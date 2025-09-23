class ResumeImportJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)
    return unless user.cv.attached?

    chat = RubyLLM.chat(model: "gpt-5-nano-2025-08-07", provider: :openai)
    response = chat.with_schema(ProfileSchema).ask('Give me all the user info', with: user.cv)
    update_user(user, response.content)
  rescue => e
  end

  private

  def update_user(user, content)
    user.update(
      name: content['name'].presence || user.name,
      email: content['email'].presence || user.email,
      phone: content['phone'].presence || user.phone,
      linkedin: content['linkedin'].presence || user.linkedin,
      github: content['github'].presence || user.github,
      summary: content['summary'].presence || user.summary
    )
    update_languages(user, content['languages'])
    update_skills(user, content['skills'])
    update_experiences(user, content['experiences'])
    update_educations(user, content['educations'])
  end

  def update_languages(user, languages)
    user.languages.destroy_all
    languages.each do |language|
      record = Language.create(language)
      record.user = user
      record.save!
    end
  end

  def update_skills(user, skills)
    user.skills.destroy_all
    skills.each do |skill|
      record = Skill.create(skill)
      record.user = user
      record.save!
    end
  end

  def update_experiences(user, experiences)
    user.experiences.destroy_all
    experiences.each do |experience|
      record = Experience.create(experience)
      record.user = user
      record.save!
    end
  end

  def update_educations(user, educations)
    user.educations.destroy_all
    educations.each do |education|
      record = Education.create(education)
      record.user = user
      record.save!
    end
  end
end
