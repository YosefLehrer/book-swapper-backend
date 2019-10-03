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
        user_books = user.books
        trades = Trade.all.select {|trade| trade.requestee.user.id == user_id}
        book_from_trade = trades.map do |trade|
            {owned_book: trade.owned_book.book, requestee: trade.requestee.book, trade_id: trade.id}
        end
        render json: {books: user_books, trades: book_from_trade}
    end

    private
    
    def user_params
        params.require(:user).permit(:user_name, :password)
    end
end
