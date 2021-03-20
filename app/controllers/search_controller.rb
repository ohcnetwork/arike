class SearchController < ApplicationController
  # TODO : Implement before action for priveleged users who can query db

  # You can implement pattern searching using LIKE clause
  # Example : SELECT * FROM patients WHERE first_name LIKE "%pattern%";

  def index
    result = User.where(role: "asha").select(:id, :full_name)
    data = result.map { |r| r.attributes.symbolize_keys }
    render :json => data
  end
end
