class Git

	PROJECTS_PATH = "/tmp/projects"
	TEST_RESULT_FOLDER = "test_result"

	attr_accessor :local_path

	def initialize(_repository_url, _project_name, _branch_name)
		path = [PROJECTS_PATH, _project_name, _branch_name].join('/')
		self.local_path = path
		FileUtils.rm_rf(path) rescue nil
		FileUtils.mkdir_p(path)
		FileUtils.mkdir_p(get_output_path())

		system("git clone -b #{_branch_name} #{_repository_url} #{path}")
	end

	def get_output_path
		[self.local_path, TEST_RESULT_FOLDER].join('/')
	end

end