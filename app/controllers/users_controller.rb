class UsersController < ApplicationController
    before_action :require_no_user!
    
    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.new(user_params)

        if @user.save
            @user.reset_session_token!
            session[:session_token] = @user.session_token
            email = UserMailer.welcome_email(@user)
            email.deliver_now
            redirect_to cats_url
        else
            render :new
        end
    end

    private

    def user_params
        params.require(:user).permit(:username, :password)
    end
end