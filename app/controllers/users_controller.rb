class UsersController < ApplicationController
skip_before_action :authorized, only: :create
    def create
        new_user = User.create(user_params)
        if new_user.valid?
            session[:user_id] = new_user.id
            render json: new_user, status: :created
        else    
            render json: {errors: new_user.errors.full_messages}, status: :unprocessable_entity
        end

    end

    def show
        current_user = User.find(session[:user_id])
        render json: current_user, status: :created
    rescue ActiveRecord::RecordNotFound
        render json: {error: "Please signup or login"}, status: :unauthorized
    end



    private

    def user_params
        params.permit(:username, :password, :password_confirmation)
    end
end
