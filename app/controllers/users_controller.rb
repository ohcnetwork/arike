class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = params.require(:user).permit(:full_name, :first_name)
    User.create!(user)
    redirect_to root_path
  end
end
