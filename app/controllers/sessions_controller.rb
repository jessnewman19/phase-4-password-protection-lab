class SessionsController < ApplicationController

    #Find the user and authenticate with the password.
    #If user is authenticated, set the session id and render the user as json
    #Else, render unauthorized
    def create 
        user = User.find_by(username: params[:username])
        if user&.authenticate(params[:password])
            session[:user_id] = user.id 
            render json: user, status: :created 
        else 
            render json: {error: "Invalid username or password"}, status: :unauthorized
        end
    end

    #Delete the user id from the session upon logout
    def destroy 
        session.delete :user_id
        head :no_content
    end
    
end
