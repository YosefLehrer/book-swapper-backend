class AuthController < ApplicationController
    def login
        byebug
        user = User.find_by(user_name: params[:user_name])
        if user
            render json: {
                token: JWT.encode({userId: user.id}, ENV['JWT_SECRET'])
            }
        else
            render json: {error: "Invalid username or password"}
        end    
    end

    def autologin
    end
end
