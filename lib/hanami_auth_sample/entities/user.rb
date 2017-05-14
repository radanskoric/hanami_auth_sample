require "bcrypt"

# User of the application
class User < Hanami::Entity
  def password
    BCrypt::Password.new(encrypted_password)
  end
end
