class UsersController < ApplicationController
  def index
  end

  def new
    @user = User.new
  end

  def signup
    @user = User.new
  end

  def edit
    @user = User.find_by_id(params[:id])
  end

  def update
    newUser = params.require(:user).permit(:full_name, :first_name, :role, :email, :phone)
    user = User.find_by_id(params[:id])
    if user
      user.update(full_name: newUser[:full_name], first_name: newUser[:first_name], role: newUser[:role], email: newUser[:email], phone: newUser[:phone])
    end
    redirect_to users_path
  end

  def create
    user = params.require(:user).permit(:full_name, :first_name, :role, :email, :phone, :password, :verified)
    user[:verified] = false
    if user[:password].strip.empty?
      user[:password] = "arike"
    end
    User.create!(user)
    redirect_to home_path
  end

  def verify
    user = User.find_by_id(params[:id])
    if user
      user.update(verified: true)
    end
    redirect_to users_path
  end
end
