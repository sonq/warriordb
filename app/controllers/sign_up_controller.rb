# app/controllers/sign_up_controller.rb
class SignUpController < ApplicationController
  skip_before_action :authenticate, only: [ :new, :create ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(sign_up_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Üyelik oluşturuldu!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                               :first_name, :last_name, :phone, :role)
  end
end
