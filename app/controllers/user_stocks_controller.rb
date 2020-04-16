class UserStocksController < ApplicationController


    def create
        stock = Stock.check_db(params[:ticker])
        if stock.blank?
          stock = Stock.new_lookup(params[:ticker])
          stock.save
        end
        if UserStock.where(user: current_user).where(stock: stock).blank?
          @user_stock= UserStock.create(user: current_user, stock: stock)
          flash[:notice] = "Stock "+ stock.ticker + " was successfully added"
        else
          flash[:alert] = "You are already tracking " + stock.ticker
        end
        redirect_back fallback_location: '/'
    end

    def destroy
      stock = Stock.find(params[:id])
      user_stock = UserStock.where(user: current_user).where(stock: stock).first
      user_stock.destroy
      flash[:alert] = stock.ticker + " was removed from you portfolio"
      redirect_back fallback_location: '/'
    end

end
