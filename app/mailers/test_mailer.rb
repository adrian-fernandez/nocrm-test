class TestMailer < ActionMailer::Base

	def summary_email(recipients, commits, project_name, branch, attach)
		@content = File.read(attach)
		@commits = commits

		Rails.logger.fatal "*** #{Time.now.to_s} Sending e-mail:"
		Rails.logger.fatal "  * Recipients: #{recipients.inspect}"
		Rails.logger.fatal "  * Commits: #{commits.inspect}"
		Rails.logger.fatal "  * Project_name: #{project_name}"
		Rails.logger.fatal "  * branch: #{branch}"

		mail(to: recipients, subject: "[TEST] Results for '#{project_name}' / '#{branch}'")
	end

end
