class UsersController < ApplicationController
  def my_portfolio
    @user_stocks = current_user.stocks
    @user = current_user
  end
  
  def my_friends
    @friendships = current_user.friends
  end
  
  def search
    @users = User.search(params[:search_param])
    if @users
      @users = current_user.except_current_user(@users)
      render partial: 'friends/lookup'
    else
      render status: :not_found, nothing: true
    end
  end

  def add_friend
    @friend = User.find(params[:friend])
    current_user.friendships.build(friend_id: @friend.id)
    if current_user.save
      redirect_to my_friends_path, notice: "Friend was successfully added."
    else
      redirect_to my_friends_path, flash[:error] = "There was an error with adding user as friend."
    end
  end
  
  def not_friends_with?(friend_id)
    friendships.where(friend_id: friend_id).count < 1
  end

  def except_current_user(users)
    users.reject {|user| user.id == self.id}
  end

  def self.search(param)
    return User.none if param.blank?
    
    param.strip!
    param.downcase!
    (first_name_matches(param) + last_name_matches(param) + email_matches(param)).uniq
  end

  def self.first_name_matches(param)
    matches('first_name', param)
  end

  def self.last_name_matches(param)
   matches('last_name', param)
  end
  
  def self.email_matches(param)
    matches('email', param)
  end

  def self.matches(field_name, param)
    where("lower(#{field_name}) like ?", "%#{param}%")
  end

  def show
    @user = User.find(params[:id])
    @user_stocks = @user.user_stocks
  end
  
end