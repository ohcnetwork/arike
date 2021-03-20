class WardsController < ApplicationController
  def index
    @wards = Ward.all
  end

  def new
  end

  def show
    @ward = Ward.find(params[:id])
  end

  def edit
  end
end
