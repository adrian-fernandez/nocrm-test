class TestMailer < ActionMailer::Base

	def summary_email(recipients, project_name, branch, attach)
		@content = File.read(attach)

		mail(to: recipients, subject: "[TEST] Results for '#{project_name}' / '#{branch}'")
	end

end
