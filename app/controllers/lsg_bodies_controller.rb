class LsgBodiesController < ApplicationController
  before_action :set_lsg_body, only: %i[edit update]

  def index
    @lsg_body = policy_scope(LsgBody)
  end

  def new
    @lsg_body = LsgBody.new
    authorize @lsg_body
  end

  def create
    authorize LsgBody
    LsgBody.create(lsg_bodies_params)
    redirect_to lsg_bodies_path
  end

  def show
    id = params[:id]
    @lsg_body = LsgBody.find(id)
    authorize @lsg_body
    @wards = Ward.where(lsg_body_id: id)
  end

  def edit
    authorize @lsgbody
  end

  def update
    authorize @lsg_body
    @lsg_body.update(lsg_bodies_params)
    redirect_to lsg_body_path(params[:id])
  end

  def archive
    id = params[:lsg_body_id]
    @lsg_body = LsgBody.find(id)
    authorize @lsg_body
    @lsg_body.update(archived: true, archived_by: current_user.full_name, archived_at: DateTime.now)
    redirect_to lsg_bodies_path
  end

  def unarchive
    id = params[:lsg_body_id]
    @lsg_body = LsgBody.find(id)
    authorize @lsg_body
    @lsg_body.update(archived: false, archived_by: nil, archived_at: nil)
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
