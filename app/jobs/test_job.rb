class TestJob < ActiveJob::Base
  queue_as :default
 
  def perform(_repository_url, _project_name, _branch_name)
    g = Git.new(_repository_url, _project_name, _branch_name)

    bundle exec rspec spec --format h > output.html
  end
end