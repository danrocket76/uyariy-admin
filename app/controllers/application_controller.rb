class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def authenticate_admin_user!
    authenticate_user! # Ensures the user is logged in via Devise

    unless current_user.admin? || current_user.audiologist?
      flash[:alert] = "Authorized personnel only!."
      sign_out current_user # Force logout
      redirect_to new_user_session_path # Send back to login
    end
  end

  def current_admin_user
    current_user
  end

  # Changes to the importmap will invalidate the etag for HTML responses
  #stale_when_importmap_changes
end
