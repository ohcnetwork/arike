class WardsController < ApplicationController
  def index
    @wards = Ward.all
  end

  def new
  end

  def show
  end

  def edit
  end
end
