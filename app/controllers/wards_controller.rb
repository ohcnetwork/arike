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
  end
end
