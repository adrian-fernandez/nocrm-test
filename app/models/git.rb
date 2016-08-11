class Git

	PROJECTS_PATH = "/tmp/projects"
	TEST_RESULT_FOLDER = "test_result"

	attr_accessor :local_path

	# data = {
	# =>  		repository_url string Full URL of repository
	# =>  		project_name string
	# =>  		branch_name string
	# =>  		recipients array<string>
	# =>  		private boolean
	# 		  }

	def initialize(data)
		path = [PROJECTS_PATH, data[:project_name], data[:branch_name]].join('/')
		self.local_path = path
		FileUtils.rm_rf(path) rescue nil
		FileUtils.mkdir_p(path)
		FileUtils.mkdir_p(get_output_path())

		if data[:private]
			data[:repository_url].gsub!("https://github.com", "https://#{GITHUB[:username]}:#{GITHUB[:password]}@github.com")
		end

		system("git clone -b #{data[:branch_name]} #{data[:repository]} #{path}")
	end

	def get_output_path
		[self.local_path, TEST_RESULT_FOLDER].join('/')
	end

end