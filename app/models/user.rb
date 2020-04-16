class User < ApplicationRecord

  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

   def has_stock(stock)
     user_stock= self.stocks.where(ticker: stock.ticker)
     !user_stock.empty?
   end

   def has_friend(friend)
      !Friendship.where(user: self).where(friend: friend).blank?
   end

end
