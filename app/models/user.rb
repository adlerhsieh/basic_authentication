class User < ActiveRecord::Base
	attr_accessor :password, :password_confirmation
	before_save :password_digest
	validates :name, presence: true, uniqueness: true
	validates :password, presence: true, length: { minimum: 3 }
	validates_confirmation_of :password

	def password_digest
		if password.present?
			self.password_salt = BCrypt::Engine.generate_salt
			self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
		end
	end

	def self.authenticate(name, password)
		user = User.find_by_name(name)
		if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
			user
		end
	end
end
