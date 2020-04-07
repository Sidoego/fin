class Stock < ApplicationRecord

    def self.new_lookup(ticker_smbl)
        client = IEX::Api::Client.new(
            publishable_token: 'Tpk_ccfd5034761a48f48193c7a4f9876838',
            secret_token: 'Tsk_575ee15c9de048ba9952dfc31f78c7f9',
            endpoint: 'https://sandbox.iexapis.com/v1'
        )
        begin
          new(ticker: ticker_smbl.upcase, name: client.company(ticker_smbl).company_name , last_price: client.price(ticker_smbl))
        rescue => exception
          return nil
        end
    end

end
