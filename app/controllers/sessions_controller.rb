class SessionsController < ApplicationController
    before_action :require_no_user!, only: [:create, :new]

    def new
        # Renders a form for user to enter their username and password
        @user = User.new
        render :new
    end

    def create
        # Verify user's username and password
        user = User.find_by_credentials(params[:user][:username], params[:user][:password])

        if user.nil?
            render json: 'Credentials were wrong'
        else
            # Reset the user's session_token, update session hash with the new session_token, and redirect the user to the cats index page
            user.reset_session_token!
            session[:session_token] = user.session_token
            redirect_to cats_url
        end
    end

    def destroy
        if current_user
            current_user.reset_session_token!
        end
        session[:session_token] = nil
        redirect_to new_session_url
    end
end