class WardsController < ApplicationController
  def index
    @wards = Ward.all
  end

  def new
    @ward = Ward.new
  end

  def show
    @ward = Ward.find(params[:id])
  end

  def create
    p = params[:ward]
    ward = LsgBody.find(p[:lsg_body]).wards.create!(name: p[:name], number: p[:number])
    redirect_to ward_path(ward.id)
  end

  def edit
    @ward = Ward.find(params[:id])
  end

  def update
    id = params[:id]
    p = params[:ward]
    lsg_body = LsgBody.find(p[:lsg_body])

    Ward.update(id, name: p[:name], number: p[:number], lsg_body: lsg_body)
    redirect_to ward_path(id)
  end
end
