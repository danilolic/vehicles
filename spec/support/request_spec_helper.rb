module RequestSpecHelper
  # Parse JSON response to ruby hash
  def json_response
    JSON.parse(response.body)
  end

  def authenticate_user(user)
    session = JWTSessions::Session.new(payload: { user_id: user.id, role: user.role })
    session.login
  end

  def access_token(user)
    token = authenticate_user(user)[:access]
    "Bearer #{token}"
  end
end
