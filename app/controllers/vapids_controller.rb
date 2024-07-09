class VapidsController < ApplicationController
	def public_key
    	render plain: Rails.application.credentials.dig(:webpush, :public_key)
  end
end
