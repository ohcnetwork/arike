class SearchController < ApplicationController
  # TODO : Implement before action for priveleged users who can query db

  # You can implement pattern searching using LIKE clause
  # Example : SELECT * FROM patients WHERE first_name LIKE "%pattern%";

  def with_read_only_connection
    original_connection = ActiveRecord::Base.remove_connection
    ActiveRecord::Base.establish_connection(:development)
    ActiveRecord::Base.connection.execute("set session characteristics as transaction read only;")
    yield
  ensure
    ActiveRecord::Base.establish_connection(original_connection)
  end

  def index
    # query = params[:query]
    # res = with_read_only_connection do
    #   ActiveRecord::Base.connection.execute("#{query}")
    # end
    # render json: res.to_json

    # sending asha members info to AutoComplete react component
    result = User.where(role: "asha").select(:id, :full_name)
    data = result.map { |r| r.attributes.symbolize_keys }
    render :json => data
  end
end
