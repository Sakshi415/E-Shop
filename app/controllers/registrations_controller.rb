 #frozen_string_literal: true

class RegistrationsController < DeviseTokenAuth::RegistrationsController
  #  before_action :configure_sign_up_params, only: [:create]
  #  before_action :configure_account_update_params, only: [:update]

  # # GET /resource/sign_up
  # def new
  #   super
  # end

  # # POST /resource
  def create
    @user = User.new(user_params)
    if @user.save!
      if params[:role] == "admin"
        @user.add_role :admin
      end
      return render json: @user, status: :created
    else
      return render json: { message: "Role is required" }, status: :unprocessable_entity
    end
  end
  
  private

  def user_params
    params.permit(:first_name, :last_name, :username, :email, :password, :password_confirmation)
  end



  # # GET /resource/edit
  # def edit
  #   super
  # end

  # # PUT /resource
  # def update
  #   if @user.email != params[:email]
  #     if User.where(email: params[:email]).present?
  #       return render json: {message: "email already exists"}, status: 200
  #     else
  #       @user.name.update(name: params[:name])
  #     end
  #   else
  #     @user.name.update(name: params[:name])
  # end


  # # DELETE /resource
  # def destroy
  #   super
  # end

  # # GET /resource/cancel
  # # Forces the session data which is usually expired after sign
  # # in to be expired now. This is useful if the user wants to
  # # cancel oauth signing in/up in the middle of the process,
  # # removing all OAuth session data.
  # def cancel
  #   super
  # end

  #  protected

  # # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  # private

  # def user_params
  #   params.require(:user).permit(:first_name, :last_name, :username, :email, :password, :password_confirmation)
  # end

end
