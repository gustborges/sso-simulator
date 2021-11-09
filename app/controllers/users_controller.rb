class UsersController < ApplicationController
  def send
    @user = User.find(params[:user_id])

  end
end
