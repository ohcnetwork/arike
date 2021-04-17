class WardsController < ApplicationController
  def index
    @wards = Ward.all
    authorize @wards
  end

  def new
    @ward = Ward.new
    authorize @ward
  end

  def show
    @ward = Ward.find(params[:id])
    authorize @ward
  end

  def create
    authorize Ward
    p = params[:ward]
    ward =
      LsgBody
        .find(p[:lsg_body])
        .wards
        .create!(name: p[:name], number: p[:number])
    redirect_to ward_path(ward.id)
  end

  def edit
    @ward = Ward.find(params[:id])
    authorize @ward
  end

  def update
    authorize Ward
    id = params[:id]
    p = params[:ward]
    lsg_body = LsgBody.find(p[:lsg_body])

    Ward.update(id, name: p[:name], number: p[:number], lsg_body: lsg_body)
    redirect_to ward_path(id)
  end

  def destroy
    authorize Ward
    Ward.delete(params[:id])

    redirect_to wards_path
  end
end
