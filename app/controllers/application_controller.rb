class ApplicationController < ActionController::API
  rescue_from CanCan::AccessDenied do |exception|
    Rails.logger.debug "Access denied on #{exception.action} #{exception.subject.inspect}"
    render json: {error: "Acesso Negado"}, status: 403
  end
  
  def current_user
    if decoded.present?
      # byebug
      User.find(decoded["user_id"])
    else
      return nil
    end
  end
  
  def decoded
    if auth_token.present?
      decoded_array = JsonWebToken.decode(auth_token)
      return decoded_array[0]
    else
      # byebug
      return nil
    end
  end
  
  def auth_token
    token = request.headers["Authorization"]
    return nil if token.nil?
    token.split(" ").last
  end
end
