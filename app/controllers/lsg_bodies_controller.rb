class LsgBodiesController < ApplicationController
  def index
    @lsg_body = LsgBody.all
    render "index"
  end

  def new
    @lsg_body = LsgBody.new
  end

  def create
    p = params[:lsg_body]
    LsgBody.create!(name: p[:name], kind: p[:kind], code: p[:code], district: p[:district])
    redirect_to lsg_bodies_path
  end
end
