class TestJob < ActiveJob::Base
  queue_as :default
 
  # data = {
  # =>      repository_url string Full URL of repository
  # =>      project_name string
  # =>      branch_name string
  # =>      recipients array<string>
  # =>      private boolean
  #       }
  def perform(data)
    g = Git.new(data)

    output_test_file = "#{g.get_output_path()}/output.html"
    system("#{g.local_path} bundle exec rspec spec --format h > #{output_test_file}")

#    TestMailer.summary_email(data[:recipients], data[:commits], data[:project_name], data[:branch_name], output_test_file)
  end
end