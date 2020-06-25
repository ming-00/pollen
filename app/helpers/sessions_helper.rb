module SessionsHelper
    def current_user
        if @current_user.nil?
            @current_user = User.find_by(id: session[:user_id])
          else
            @current_user
          end
    end

    def logged_in? 
        !current_user.nil? 
    end

    def current_user?(user)
      user == current_user
    end

     # Redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end
end