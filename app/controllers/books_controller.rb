require 'net/http'
class BooksController < ApplicationController
    def search
        searchTerm = params[:searchTerm]
        encodedSearchTerm = URI.escape(searchTerm)
        uri = URI.parse("https://www.googleapis.com/books/v1/volumes?q=#{encodedSearchTerm}")
        response = Net::HTTP.get_response(uri)
        body = JSON.parse(response.body)
        render :json => body["items"]
    end
end
