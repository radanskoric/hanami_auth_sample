# Standard repository for user entities.
class UserRepository < Hanami::Repository
  def find_by_email(email)
    users.where(email: email).first
  end

  def authenticate(email, password)
    user = find_by_email(email)
    user && user.password == password ? user : nil
  end
end
