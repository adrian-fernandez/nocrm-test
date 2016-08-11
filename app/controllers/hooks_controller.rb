class HooksController < ActionController::Base

	def index
		render text: "it works!", layout: false
	end

	def hook
		branch       = params["ref"].split("/").last
		commits      = params["commits"]
		git_url      = params["repository"]["html_url"] + ".git"
		project_name = params["repository"]["name"]
		private_repo = params["repository"]["private"]
		recipients   = commits.map(&:email)

		Rails.logger.fatal "*** #{Time.now.to_s} HOOK"
		Rails.logger.fatal "**************************************"
		Rails.logger.fatal "**************************************"
		Rails.logger.fatal "* Branch name: #{branch}"
		Rails.logger.fatal "* Commits: #{commits.inspect}"
		Rails.logger.fatal "**************************************"
		Rails.logger.fatal "**************************************"

		unless AUTHORIZED_PROJECTS.include?(project_name)
			Rails.logger.fatal " ERROR! Application not authorized"
			render text: "Unauthorized application", layout: false, status: :unauthorized
		end

		TestJob.perform_later({ repository_url: git_url,
								project_name: project_name,
								branch_name: branch,
								private: private_repo,
								recipients: recipients
			   				  })

		render text: "hook logged!", layout: false
	end
end
