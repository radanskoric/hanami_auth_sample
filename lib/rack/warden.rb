Warden::Strategies.add(:password) do
  def valid?
    params.key? "session"
  end

  def authenticate!
    session = params["session"]
    user = UserRepository.new.authenticate(session["email"], session["password"])
    user.nil? ? fail!("Invalid user name or password") : success!(user)
  end
end
