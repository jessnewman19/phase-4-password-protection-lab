class UsersController < ApplicationController
    before_action :authorize, only: [:show]

    def create 
        #create a new user
        user = User.create(user_params)
        if user.valid? 
            #save the user's id in the session hash
            session[:user_id] = user.id
            #return user object in JSON response
            render json: user, status: :created 
        else 
            render json: { error: user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def show 
        user = User.find(session[:user_id])
            render json: user
    end

    private 

    def user_params 
        params.permit(:username, :password, :password_confirmation)
    end

    def authorize 
        return render json: {error: "Not authorized"}, status: :unauthorized unless session.include? :user_id
    end

end
