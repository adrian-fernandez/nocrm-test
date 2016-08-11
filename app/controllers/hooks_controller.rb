class HooksController < ActionController::Base

	def index
		render text: "it works!", layout: false
	end

	def hook
		branch = params["ref"].split("/").last
		commits = params["commits"]
		git_url = params["repository"]["html_url"] + ".git"
		project_name = params["repository"]["name"]

		Rails.logger.fatal "*** #{Time.now.to_s} HOOK"
		Rails.logger.fatal "**************************************"
		Rails.logger.fatal "**************************************"
		Rails.logger.fatal "* Branch name: #{branch}"
		Rails.logger.fatal "* Commits: #{commits.inspect}"
		Rails.logger.fatal "**************************************"
		Rails.logger.fatal "**************************************"

		TestJob.perform_later(git_url, project_name, branch)

		render text: "hook logged!", layout: false
	end
end
