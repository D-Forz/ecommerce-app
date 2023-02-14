module SessionHelpers
  def sign_in(user)
    post sessions_path, params: { login: user.username, password: user.password }
  end
end
