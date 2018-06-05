class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "Giriş Başarılı"
      redirect_to user_path(user)
    else
      flash.now[:danger] = "Email ya da şifre hatalı. Hangisi olduğunu söyleyemem :)"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Çıkış işlemi başarılı"
    redirect_to root_path
  end

end