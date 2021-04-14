class UsersController < ApplicationController
  skip_before_action :ensure_logged_in, only: %i[signup create]
  before_action :ensure_superuser, only: %i[update verify]
  before_action :ensure_facility_access, only: %i[index new]

  def index; end

  def new
    @user = User.new
  end

  def signup
    redirect_to dashboard_path if current_user
    @user = User.new
    @user[:verified] = false

    render layout: "public"
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    new_user =
      params
        .require(:user)
        .permit(:full_name, :first_name, :role, :email, :phone)
    user = User.find(params[:id])
    if user
      user.update(
        full_name: new_user[:full_name],
        first_name: new_user[:first_name],
        role: new_user[:role],
        email: new_user[:email],
        phone: new_user[:phone],
      )
    end
    redirect_to users_path
  end

  def create
    user =
      params
        .require(:user)
        .permit(
          :full_name,
          :first_name,
          :role,
          :email,
          :phone,
          :password,
          :verified,
        )
    user[:verified] = false

    if !user[:password] || user[:password].strip.empty?
      user[:password] = "arike"
    end

    user = User.new(user)

    if user.valid?
      user.save
      redirect_to new_session_path, notice: "You have successfully signed up!"
    else
      flash[:error] = user.errors.full_messages.to_sentence
      redirect_to signup_path
    end
  end

  def assign_facility
    assignables = params.require(:facility).permit(:facility_id, :user_id)
    @facility = policy_scope(Facility).find(assignables[:facility_id])
    authorize @facility

    user =
      User.add_to_facility(assignables[:user_id], assignables[:facility_id])
    if user.save
      flash[:success] = "Successfully assigned #{user.full_name} to this facility!"
      redirect_to show_facility_users_path(assignables[:facility_id])
    else
      flash[:error] = user.errors.full_messages.to_sentence
      redirect_to show_facility_users_path(assignables[:facility_id])
    end
  end

  def unassign_facility
    assignables = params.require(:facility).permit(:facility_id, :nurse_id)
    @facility = policy_scope(Facility).find(assignables[:facility_id])
    authorize @facility

    user =
      User.remove_from_facility(
        assignables[:nurse_id],
        assignables[:facility_id],
      )
    if user.save
      flash[:success] = "Successfully removed #{user.full_name} to this facility!"
      redirect_to show_facility_users_path(assignables[:facility_id])
    else
      flash[:error] = user.errors.full_messages.to_sentence
      redirect_to show_facility_users_path(assignables[:facility_id])
    end
  end

  def verify
    user = User.find(params[:id])
    user.update(verified: true) if user
    redirect_to users_path
  end
end
