class JsonWebToken
  def self.encode(payload, exp = 2.hours.from_now)
    # set expiry to one hour from now
    payload[:exp] = exp.to_i
    # sign token with application secret
    JWT.encode(payload, Rails.application.secret_key_base)
  end

  def self.decode(token)
    # get payload; first index in decoded Array
    body = JWT.decode(token, Rails.application.secret_key_base)[0]
    HashWithIndifferentAccess.new body
    # rescue from all decode errors
  rescue JWT::DecodeError => e
    # raise custom error to be handled by custom handler
    raise ExceptionHandler::InvalidToken, e.message
  end
end
