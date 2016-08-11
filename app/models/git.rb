class Git

	PROJECTS_PATH = "/tmp/projects"

	def initialize(_repository_url, _project_name, _branch_name)
		path = [PROJECTS_PATH, _project_name, _branch_name].join('/')
		FileUtils.rm_rf(path) rescue nil
		FileUtils.mkdir_p(path)

		system("git clone -b #{_branch_name} #{_repository_url} #{path}")
	end

end