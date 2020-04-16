class Stock < ApplicationRecord

    has_many :user_stocks
    has_many :users, through: :user_stocks

    validates :name, :ticker, presence: true



    def self.new_lookup(ticker_smbl)
        client = IEX::Api::Client.new(
            publishable_token: Rails.application.credentials.iex_client[:sandbox_api_key],
            secret_token: Rails.application.credentials.iex_client[:secret_key],
            endpoint: 'https://sandbox.iexapis.com/v1'
        )
        begin
          new(ticker: ticker_smbl.upcase, name: client.company(ticker_smbl).company_name , last_price: client.price(ticker_smbl), news: client.news(ticker_smbl))
        rescue => exception
          return nil
        end
    end

    def self.check_db(ticker_smbl)
      find_by_ticker(ticker_smbl)
    end

    def get_update
      client = IEX::Api::Client.new(
          publishable_token: 'Tpk_ccfd5034761a48f48193c7a4f9876838',
          secret_token: 'Tsk_575ee15c9de048ba9952dfc31f78c7f9',
          endpoint: 'https://sandbox.iexapis.com/v1'
      )
      begin
        self.last_price = client.price(self.ticker)
        self.news = client.news(self.ticker)
        self.save
      rescue => exception
        return nil
      end
    end

end
