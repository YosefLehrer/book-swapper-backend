require 'net/http'
class BooksController < ApplicationController
    def search
        searchTerm = params[:searchTerm]
        encodedSearchTerm = URI.escape(searchTerm)
        uri = URI.parse("https://www.googleapis.com/books/v1/volumes?q=#{encodedSearchTerm}")
        response = Net::HTTP.get_response(uri)
        body = JSON.parse(response.body)
        parsedArrayOfBooks = body["items"].map do |book|
            {
                title: book["volumeInfo"]["title"],
                author: book["volumeInfo"]["authors"] ? book["volumeInfo"]["authors"][0] : "Author not found",
                # isbn: book["volumeInfo"]["industryIdentifiers"].find {|identifier| identifier["type"] === "ISBN_10" || identifier["type"] === "OTHER"}["identifier"]
                img: book["volumeInfo"]["imageLinks"] ? book["volumeInfo"]["imageLinks"]["thumbnail"]: "https://cdn2.iconfinder.com/data/icons/unigrid-phantom-multimedia-vol-6/60/020_256_rules_do_not_list_book_history_education_study_learn_knowledge-128.png",
                description: book["volumeInfo"]["description"],
                publisheddate: book["volumeInfo"]["publishedDate"],
                pagecount: book["volumeInfo"]["pageCount"],
                rating: book["volumeInfo"]["averageRating"],
                infolink: book["volumeInfo"]["infoLink"],
                googleid: book["id"]
            }
        end
        render :json => parsedArrayOfBooks
    end

    def show
        book = Book.find_by(googleid: params["id"])
        if book
            usersArray = book.users.map {|user| user.user_name}
            render json: {users: usersArray}
        else
            render json: {users: "No users own this book"}
        end
    end
end
