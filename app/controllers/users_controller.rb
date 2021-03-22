class UsersController < ApplicationController
  # skip_before_action :ensure_logged_in, only: [:signup, :create]
  before_action :ensure_superuser

  def index
  end

  def new
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

    if !user[:password] || user[:password].strip.empty?
      user[:password] = "arike"
    end

    user = User.new(user)

    if user.valid?
      user.save
      redirect_to new_user_path, notice: "New User Created!"
    else
      flash[:error] = user.errors.full_messages.to_sentence
      redirect_to new_user_path
    end
  end

  def verify
    user = User.find_by_id(params[:id])
    if user
      user.update(verified: true)
    end
    redirect_to users_path
  end
end
