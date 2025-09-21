# app/controllers/profiles_controller.rb
class ProfilesController < ApplicationController

  # GET /profile/new
  def new
    @user = current_user
    # Build one empty record for each nested association so the form shows at least one row
    @user.languages.build
    @user.educations.build
    @user.experiences.build
    @user.skills.build
  end

  # PATCH /profile
  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to root_path, notice: 'Profile updated!'
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name, :phone, :linkedin, :github, :summary,
      languages_attributes:   [ :id, :name, :proficiency, :_destroy ],
      educations_attributes:  [ :id, :name, :institution, :degree, :start_date, :end_date, :description, :notes, :_destroy ],
      experiences_attributes: [ :id, :title, :company, :location, :start_date, :end_date, :description, :notes, :_destroy ],
      skills_attributes:      [ :id, :name, :proficiency, :_destroy ]
    )
  end
end
