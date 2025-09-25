class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :job_applications, dependent: :destroy
  has_many :languages,   dependent: :destroy
  has_many :educations,  dependent: :destroy
  has_many :experiences, dependent: :destroy
  has_many :skills,      dependent: :destroy
  has_many :ignored_jobs, dependent: :destroy

  has_one_attached :cv

  accepts_nested_attributes_for :languages,   allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :educations,  allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :experiences, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :skills,      allow_destroy: true, reject_if: :all_blank


  def profile_json
    {
      name: name,
      email: email,
      phone: phone,
      linkedin: linkedin,
      github: github,
      summary: summary,
      languages: languages.map { |lang| { name: lang.name, proficiency: lang.proficiency } },
      educations: educations.map { |edu| { institution: edu.institution, degree: edu.degree, start_date: edu.start_date, end_date: edu.end_date } },
      experiences: experiences.map { |exp| { company: exp.company, start_date: exp.start_date, end_date: exp.end_date, description: exp.description } },
      skills: skills.map { |skill| { name: skill.name, proficiency: skill.proficiency } }
    }.to_json
  end
end
