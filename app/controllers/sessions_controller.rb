class SessionsController < ApplicationController
  before_action :require_authentication,only:[:destroy]

  def new
  end

  def create
    if (user = User.find_by(name: params[:name]))&.authenticate(params[:password]) # この行を変更
      start_new_session_for user
      redirect_to after_authentication_url
    else
      redirect_to new_session_path, alert: "Try another name or password."
    end
  end

  def destroy
    terminate_session
    redirect_to new_session_path
  end
  private

  def require_authentication
    redirect_to new_session_path unless Current.user
  end
end
