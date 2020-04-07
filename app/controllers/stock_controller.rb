class StockController < ApplicationController

    def search
      if params[:stock].present?
        @stock = Stock.new_lookup(params[:stock])
        if @stock
          respond_to do |format|
            format.js { render partial: 'stock/results'}
          end
        else
          respond_to do |format|
            flash[:alert] = "Please enter a valid symbol to search"
            format.js  { render partial: 'stock/results'}
          end
        end
      else
        respond_to do |format|
          flash[:alert] = "Please enter a symbol to search"
          format.js  { render partial: 'stock/results'}
        end
      end
    end
end
