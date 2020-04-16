class UserController < ApplicationController

    before_action :authenticate_user!

    def index
       @tracking_stock = current_user.stocks
    end

    def show_friend
      @user = User.find(params[:user])
      @tracking_stock = @user.stocks
      #redirect_to friend_path
    end

    def friends_list
      @friends_me = Friendship.where(friend_id: current_user)
      @friends_i = Friendship.where(user_id: current_user)
    end

    def search
      if params[:email].present?
        @user = User.where("email like ?", "%#{params[:email]}%")
        if !@user.empty?
          respond_to do |format|
            format.js { render partial: 'user/friend_results'}
          end
        else
          respond_to do |format|
            flash.now[:alert] = "Please enter a valid email to search"
            format.js  { render partial: 'user/friend_results'}
          end
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Please enter a email to search"
          format.js  { render partial: 'user/friend_results'}
        end
      end
    end

end
