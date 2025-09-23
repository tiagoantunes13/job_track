# app/controllers/profiles_controller.rb
class ProfilesController < ApplicationController
  before_action :set_current_user

  # GET /profile/new
  def new
    @user.languages.build if @user.languages.empty?
    @user.educations.build if @user.educations.empty?
    @user.experiences.build if @user.experiences.empty?
    @user.skills.build if @user.skills.empty?
  end

  def edit
  end

  # PATCH /profile
  def update
    if @user.update(user_params)
      redirect_to root_path, notice: 'Profile updated!'
    else
      render :new
    end
  end

  private

  def set_current_user
    @user = current_user
  end

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
