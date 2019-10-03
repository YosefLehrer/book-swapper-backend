class TradesController < ApplicationController

  def find_or_create
    token = params["token"]
    user_id = JWT.decode(token, ENV["JWT_SECRET"])[0]["userId"]
    requester = OwnedBook.find_by(user_id: user_id, book_id: params["requester_book"])
    requestee = OwnedBook.find_by(user_id: params["requestee_id"], book_id: params["requestee_book"])
    trade = Trade.find_by(owned_book_id: requester.id, requestee_id: requestee.id)
      if trade
        render json: {message: "This trade has already been requested"}
      else
        Trade.create(owned_book_id: requester.id, requestee_id: requestee.id)
        render json: {message: "Your trade has been processed"}
      end
  end

  def accept_trade
    trade = Trade.find(params[:trade_id])
    requester_id = trade.owned_book.user_id
    requestee_id = trade.requestee.user_id
    trade.owned_book.update(user_id: requestee_id)
    trade.requestee.update(user_id: requester_id)
    trade.destroy!()
    render json: {message: "Trade successful"}
  end
  
end
