# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  skip_before_action :authenticate, only: [ :new, :create ]

  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Giriş yapıldı!"
    else
      flash.now[:alert] = "Başarısız deneme!"
      render :new, status: :unprocessable_entity
    end
  end
  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Çıkış yapıldı!"
  end
end
