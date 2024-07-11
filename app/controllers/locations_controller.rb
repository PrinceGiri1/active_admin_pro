class LocationsController < ApplicationController
	def states
    country_code = params[:country_code]
    states = CS.states(country_code)
    render json: states.map { |code, name| { code: code, name: name } }
  end

  def cities
    country_code = params[:country_code]
    state_code = params[:state_code]
    cities = CS.cities(state_code, country_code)
    render json: cities
  end
end
