class UsersController < ApplicationController
    def create
        user = User.new(user_params)
        if user.valid?
            user.save
            render json: {user: user, token: JWT.encode({userId: user.id}, ENV['JWT_SECRET'])}
        else
            render json: {error: "Username has already been taken"}
        end
    end

    def user_library
        token = request.headers['Authorization']
        user_id = JWT.decode(token, ENV["JWT_SECRET"])[0]["userId"]
        user = User.find(user_id)
        render json: user.books
    end

    private
    def user_params
        params.require(:user).permit(:user_name, :password)
    end
end
