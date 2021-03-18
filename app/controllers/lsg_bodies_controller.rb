class LsgBodiesController < ApplicationController
  def new
    @lsg_body = LsgBody.new
  end

  def create
    p = params[:lsg_body]
    LsgBody.create!(name: p[:name], kind: p[:kind])
    redirect_to home_path
  end
end
