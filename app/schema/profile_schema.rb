
class ProfileSchema < RubyLLM::Schema
  string :email, description: "The user's email address"
  string :phone, description: "The user's phone number"
  string :linkedin, description: "The user's LinkedIn profile URL"
  string :github, description: "The user's GitHub profile URL"
  string :summary, description: "A brief summary about the user"
  string :name, description: "The user's full name"
  array :languages, description: "A list of languages the user speaks, like portuguese, english, and more you know? You can make assumptions if you want" do
    object do
      string :name, description: "The name of the language"
      integer :proficiency, description: "The proficiency level in the language { beginner: 0, intermediate: 1, advanced: 2, fluent: 3, native: 4 }"
    end
  end
  array :skills, description: "A list of skills the user possesses" do
    object do
      string :name, description: "The name of the skill"
      integer :proficiency, description: "The proficiency level in the skill { beginner: 0, intermediate: 1, advanced: 2, expert: 3 }"
    end
  end
  array :experiences, description: "A list of professional experiences" do
    object do
      string :title, description: "The job title"
      string :company, description: "The company name"
      string :location, description: "The location of the job"
      string :start_date, description: "The start date of the job (YYYY-MM)"
      string :end_date, description: "The end date of the job (YYYY-MM or 'Present')"
      string :description, description: "A brief description of the job responsibilities and achievements"
    end
  end
  array :educations, description: "A list of courses/high school and stuff like that" do
    object do
      string :institution, description: "The name of the educational institution"
      string :degree, description: "The degree obtained"
      string :name, description: "The name of the course"
      string :start_date, description: "The start date of the education (YYYY-MM)"
      string :end_date, description: "The end date of the education (YYYY-MM or 'Present')"
      string :description, description: "A brief description of the education experience"
    end
  end
end