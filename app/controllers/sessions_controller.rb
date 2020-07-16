class SessionsController < Clearance::SessionsController
    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
    end

    def logged_in?
        !current_user.nil?
    end

    def destroy
        sign_out
        redirect_to url_after_destroy
    end

    def current_user?(user)
        user == current_user
    end

    def following?(other_user)
        current_user.following.include?(other_user)
    end

    private

    def url_after_destroy
        root_url
    end
end