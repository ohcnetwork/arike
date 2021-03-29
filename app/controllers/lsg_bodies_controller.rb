class LsgBodiesController < ApplicationController
  def index
    @lsg_body = LsgBody.all
  end

  def new
    @lsg_body = LsgBody.new
  end

  def create
    p = params[:lsg_body]
    LsgBody.create!(name: p[:name], kind: p[:kind], code: p[:code], district: p[:district])
    redirect_to lsg_bodies_path
  end

  def show
    id = params[:id]
    @lsg_body = LsgBody.find(id)
    @wards = Ward.where(lsg_body_id: id)
  end

  def edit
    id = params[:id]
    @lsg_body = LsgBody.find(id)
  end

  def update
    id = params[:id]
    p = params[:lsg_body]

    LsgBody.update(id, name: p[:name], kind: p[:kind], code: p[:code], district: p[:district])
    redirect_to lsg_body_path(id)
  end

  def destroy
    LsgBody.delete(params[:id])

    redirect_to lsg_bodies_path
  end
end
