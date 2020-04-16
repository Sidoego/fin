class StockController < ApplicationController


    def search
      if params[:stock].present?
        @stock = Stock.new_lookup(params[:stock])
        if @stock
          respond_to do |format|
            format.js { render partial: 'user/results'}
          end
        else
          respond_to do |format|
            flash.now[:alert] = "Please enter a valid symbol to search"
            format.js  { render partial: 'user/results'}
          end
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Please enter a symbol to search"
          format.js  { render partial: 'user/results'}
        end
      end
    end

    def index
      @stock = Stock.find_by_ticker(params[:ticker])
      @stock.get_update
    end



end
