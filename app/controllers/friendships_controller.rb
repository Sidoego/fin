class FriendshipsController < ApplicationController

    def create
        friend = User.find_by_email(params[:email])
        if Friendship.where(user: current_user).where(friend: friend).blank?
          @friend= Friendship.create(user: current_user, friend: friend)
          flash[:notice] = "User "+ params[:email] + " was successfully marked as friend"
        else
          flash[:alert] = "You are already friends with" + params[:email]
        end
        redirect_back fallback_location: '/'
    end

    def destroy
      friendship = Friendship.find(params[:id])
      friendship.destroy
      flash[:alert] = friendship.friend.email + " was removed from you frindlist"
      redirect_back fallback_location: '/'
    end

end
