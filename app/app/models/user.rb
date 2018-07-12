class User < ActiveRecord::Base
	has_many :projects
	has_secure_password

	def slug
		self.username.downcase.split(" ").join("-")
	end

	def self.find_by_slug(slug)
		match = ""
	end
end
