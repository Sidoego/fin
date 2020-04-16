class AddNewsToStocks < ActiveRecord::Migration[5.2]
  def change
    add_column :stocks, :news, :json
  end
end
