class LsgBodiesController < ApplicationController
  before_action :ensure_superuser
  before_action :set_lsg_body, only: %i[edit update]

  def index
    @lsg_body = LsgBody.all
  end

  def new
    @lsg_body = LsgBody.new
  end

  def create
    LsgBody.create(lsg_bodies_params)
    redirect_to lsg_bodies_path
  end

  def show
    id = params[:id]
    @lsg_body = LsgBody.find(id)
    @wards = Ward.where(lsg_body_id: id)
  end

  def edit; end

  def update
    @lsg_body.update(lsg_bodies_params)
    redirect_to lsg_body_path(params[:id])
  end

  def destroy
    LsgBody.delete(params[:id])
    redirect_to lsg_bodies_path
  end

  private

  def set_lsg_body
    @lsg_body = LsgBody.find(params[:id])
  end

  def lsg_bodies_params
    params.require(:lsg_body).permit(:name, :kind, :code, :district_id)
  end
end
