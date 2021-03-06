require 'net/http'
class BooksController < ApplicationController
    def create_book_object(book)
        {
            title: book["volumeInfo"]["title"],
            author: book["volumeInfo"]["authors"] ? book["volumeInfo"]["authors"][0] : "Author not found",
            img: book["volumeInfo"]["imageLinks"] ? book["volumeInfo"]["imageLinks"]["thumbnail"]: "https://cdn2.iconfinder.com/data/icons/unigrid-phantom-multimedia-vol-6/60/020_256_rules_do_not_list_book_history_education_study_learn_knowledge-128.png",
            description: book["volumeInfo"]["description"] ? book["volumeInfo"]["description"] : "Description is not available",
            publisheddate: book["volumeInfo"]["publishedDate"],
            pagecount: book["volumeInfo"]["pageCount"],
            rating: book["volumeInfo"]["averageRating"],
            infolink: book["volumeInfo"]["infoLink"],
            googleid: book["id"]
        }
    end

    def search
        searchTerm = params[:searchTerm]
        encodedSearchTerm = URI.escape(searchTerm)
        uri = URI.parse("https://www.googleapis.com/books/v1/volumes?q=#{encodedSearchTerm}")
        response = Net::HTTP.get_response(uri)
        body = JSON.parse(response.body)
        parsedArrayOfBooks = body["items"].map {|book| self.create_book_object(book)}
        render :json => parsedArrayOfBooks
    end

    def show
        book = Book.find_by(googleid: params["id"])
        if book
            usersArray = book.users.map {|user| {user_name: user.user_name, user_id: user.id}}
            render json: {users: usersArray, book_id: book.id}
        else
            render json: {users: "No users own this book"}
        end
    end

    def nyt_bestsellers
        uri = URI.parse("https://api.nytimes.com/svc/books/v3/lists/overview.json?api-key=#{ENV["NYT_BESTSELLERS"]}")
        response = Net::HTTP.get_response(uri)
        body = JSON.parse(response.body)
        list = body["results"]["lists"]
        
        fiction = list.find{|obj| obj["list_name_encoded"] == "hardcover-fiction"}["books"].map do |book|
            {
                title: book["title"],
                author: book["author"] ? book["author"] : "Author not found",
                img: book["book_image"] ? book["book_image"]: "https://cdn2.iconfinder.com/data/icons/unigrid-phantom-multimedia-vol-6/60/020_256_rules_do_not_list_book_history_education_study_learn_knowledge-128.png",
            }
        end

        hardcover_nonfiction = list.find{|obj| obj["list_name_encoded"] == "hardcover-nonfiction"}["books"].map do|book|
            {
                title: book["title"],
                author: book["author"] ? book["author"] : "Author not found",
                img: book["book_image"] ? book["book_image"]: "https://cdn2.iconfinder.com/data/icons/unigrid-phantom-multimedia-vol-6/60/020_256_rules_do_not_list_book_history_education_study_learn_knowledge-128.png",
            }
        end

        render json: {fiction: fiction, nonfiction: hardcover_nonfiction}
    end
end
