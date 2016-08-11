class TestJob < ActiveJob::Base
  queue_as :default
 
  def perform(_repository_url, _project_name, _branch_name)
    Git.new(_repository_url, _project_name, _branch_name)
  end
end