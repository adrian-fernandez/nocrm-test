class TestsController < ActionController::Base

	def index
		render text: "it works!", layout: false
	end

	def hook
		Rails.logger.fatal "*** #{Time.now.to_s} HOOK"
		Rails.logger.fatal "**************************************"
		Rails.logger.fatal "**************************************"
		Rails.logger.fatal params.inspect
		Rails.logger.fatal "**************************************"
		Rails.logger.fatal "**************************************"

		render nothing: true
	end
end
