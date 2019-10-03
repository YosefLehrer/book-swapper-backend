class OwnedBooksController < ApplicationController
    def create
        token = params["user_token"]
        user_id = JWT.decode(token, ENV["JWT_SECRET"])[0]["userId"]
        book = Book.find_by(googleid: params["book"]["googleid"])
        if book
            foundOwnedBook = OwnedBook.find_by(user_id: user_id, book_id: book.id)
            if foundOwnedBook
                render json: {alreadyInLibrary: "This book is already in your library"}
            else
                newOwnedBook = OwnedBook.create(book_id: book.id, user_id: user_id)
                render json: {successfullyAddedToLibrary: "successfully Added To Library"}
            end
        else
            newBook = Book.create(book_params)
            OwnedBook.create(book_id: newBook.id, user_id: user_id)
            render json: {successfullyAddedToLibrary: "successfully Added To Library"}
        end
    end

    private

    def book_params
        params.require(:book).permit(:title, :author, :ISBN, :img, :description, :publisheddate, :pagecount, :rating, :infolink, :googleid)
    end
end
