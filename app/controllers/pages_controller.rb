class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  layout "landing"

  before_action :redirect_to_inside
  def landing; end

  def pricing; end

  def features; end

  def testimonials; end

  def contact
    @contact_message = ContactMessage.new
  end

  private

  def redirect_to_inside
    redirect_to job_applications_path if user_signed_in?
  end
end
