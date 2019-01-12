module SessionsHelper
  # Log a user into the application
  def log_in(user)
    session[:user_id] = user.id
  end

  # Log a user out of the application
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  # Returns the currently logged-in user
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  # Check if someone is logged into the application in this browser
  def logged_in?
    !current_user.nil?
  end

  # button for logging out
  def logout_button_to(title, url, options = {})
    html_options = {
      class: "logout-button-to",
      method: "delete"
    }.merge(options.delete(:html_options) || {})

    form_for :delete, url: url, html: html_options do |f|
      f.submit title, options
    end
  end
end
