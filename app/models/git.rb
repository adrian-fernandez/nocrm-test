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

		if data[:private]
			Rails.logger.fatal "*** Private repository, adding credentials"
			data[:repository_url].gsub!("https://github.com", "https://#{GITHUB[:username]}:#{GITHUB[:password]}@github.com")
			Rails.logger.fatal "*** repository_url: #{data[:repository_url]}"
		end

		Rails.logger.fatal "*** Cloning repository: "
		Rails.logger.fatal "git clone -b #{data[:branch_name]} #{data[:repository_url]} #{path}"
		system("git clone -b #{data[:branch_name]} #{data[:repository_url]} #{path}", :out => ['/tmp/log', 'a'], :err => ['/tmp/log', 'a'])

		FileUtils.mkdir_p(get_output_path())
	end

	def get_output_path
		[self.local_path, TEST_RESULT_FOLDER].join('/')
	end

end 