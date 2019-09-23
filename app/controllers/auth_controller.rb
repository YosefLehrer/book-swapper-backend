class AuthController < ApplicationController
    def login
        user = User.find_by(user_name: params[:username])
        if user && user.authenticate(params[:password])
            render json: {
                token: JWT.encode({userId: user.id}, ENV['JWT_SECRET'])
            }
        else
            render json: {error: "Invalid Username or Password"}
        end    
    end

    def autologin
        token = request.headers['Authorization']
        if token != "undefined"
            user_id = JWT.decode(token, ENV["JWT_SECRET"])[0]["userId"]
            user = User.find(user_id)
            render json: user
        else
            render json: {error: "Invalid username, password combo"}
        end
    end
end
