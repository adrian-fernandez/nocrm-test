class TestMailer < ActionMailer::Base

	def summary_email(recipients, commits, project_name, branch, attach)
		@content = File.read(attach)
		@commits = commits

		mail(to: recipients, subject: "[TEST] Results for '#{project_name}' / '#{branch}'")
	end

end
