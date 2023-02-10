class Auth::SessionsController < ApplicationController # rubocop:disable Style/ClassAndModuleChildren
  skip_before_action :protect_pages

  def new; end

  def create
    @user = User.find_by("email = :login OR username = :login", { login: params[:login] })
    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to products_path, notice: t('.logged_in')
    else
      redirect_to new_session_path, alert: t('.invalid_login')
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to products_path, notice: t('.logged_out')
  end
end