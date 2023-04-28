class AuthController < ApplicationController
  
  def login
    @user = User.where(
      'email=? OR CPF=?', 
      params[:user][:email], 
      params[:user][:cpf]).first
    # byebug
    
    if @user.authenticate(params[:user][:password])
      #Gerar um token autenticavel
      token = JsonWebToken.encode({user_id: @user.id})
      render json: {token: token, user: @user}
    else
      render json: {error: "Não foi possível fazer o login"}, status: 401
    end
  end

=begin 


=end
  def signup
    
    @user = User.new(user_params)
    
    if @user.save
      render json: @user, status: 201
      UserMailer.with(user: @user).confirm.deliver_now
    else
      render json: @user.errors, status: 422
    end
  end
  # def signup
  #   @user = User.new(user_params)
    
  #   if (@user.role == "client" || @user.role == "deliveryman") && @user.role.present?
  #     if @user.save
        
  #       #UserMailer.with(user: @user).confirm.deliver_now #envia o email de confirmação chamando o método da classe
  #       if @user.generate_validation_token
  #         render json: @user, status: 201
  #         #puts @user.validate_token
  #         UserMailer.with(user: @user).confirm.deliver_now
  #       end
  #     else
  #       render json: @user.errors, status: 422
  #     end
  #   else 
  #     render json: {error: "Não é possível cadastrar com esse papel"}, status: 401
  #  end
  # end

  def repeat_token
    @user = User.find_by(email: params[:email])
    if @user.present?
      if @user.generate_validation_token
        render json: {status: "OK"}, status: 201
        UserMailer.with(user: @user).repeat_token.deliver_now
      end
    else 
      render json: {error: "Usuário não encontrado, faça o cadastro!"}
    end
  end

  def create_owner
    @user = User.new(user_params)
    if @user.role == "owner"
      if @user.save
        if @user.validate_token
          render json: @user, status: 201
          UserMailer.with(user: @user).confirm.deliver_now
        end
      else
        render json: @user.errors, status: 422
      end
    else 
      render json: {error: "Não é possível cadastrar com esse papel"}, status: 401
    end
  end

  def confirm
    
    if params[:validate_token].present?
      
      @user = User.find_by(validate_token: params[:validate_token])
      
      if @user.present?
        if @user.validate_user?(params[:validate_token])
          render json: @user, status: 200
        else
          render json: {error: "Este token já expirou"}, status: 422
        end
      else
        render json: {error: "Usuário não existe"}, status: 404
      end
    else
      render json: {error: "Operação inválida"}, status: 400      
    end
  end

  def forgot
    @user = User.find_by(email: params[:email])
    if @user.present?
      if @user.generate_validation_token
        render json: {status: "OK"}, status: 200
        UserMailer.with(user: @user).forgot.deliver_now
      end
    else
      render json:{error: "Usuário não existe"}, status: 404
    end
  end

  def reset_password
    if params[:validate_token].present?
      @user = User.find_by(validate_token: params[:validate_token])
      if @user.present?
        @user.password = params[:password]
        @user.password_confirmation = params[:password]
        if @user.reset_password_complete?(params[:password], params[:password_confirmation])
          render json: @user
        else
          render json: @user.errors, status: 422
        end
      else
        render json: {error: "Usuário não encontrado"}, status: 404
      end
    else 
      render json: {error: "Operação inválida"}, status: 422
    end
  end

  def user_params
    params.require(:user).permit(
      :name, 
      :email, 
      :birthdate,
      :phone, 
      :password,
      :role,
      :password_confirmation#,
      # :validate_token,
      # :validate_token_expiry_at
      )
  end
 
end
