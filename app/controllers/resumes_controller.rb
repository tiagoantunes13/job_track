class ResumesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:new, :create]

  def new;end

  def create
    @user.cv.attach(params[:cv])
    if @user.cv.attached?
      ResumeImportJob.perform_later(@user.id)
      redirect_to root_path, notice: "CV imported successfully. Processing in background."
    else
      flash.now[:alert] = "Please attach a CV."
      render :new
    end
  end

  private

  def set_user
    @user = current_user
  end
end
