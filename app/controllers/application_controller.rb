class ApplicationController < ActionController::Base
    helper_method :current_user

    def current_user
        if session[:session_token].nil?
            return nil
        end

        @current_user ||= User.find_by(session_token: session[:session_token])
    end

    def require_no_user!
        redirect_to cats_url if current_user
    end

end
