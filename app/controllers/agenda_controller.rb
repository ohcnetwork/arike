class AgendaController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @scheduled_patients = Visit.scheduled_patients
    puts @scheduled_patients
  end
end
