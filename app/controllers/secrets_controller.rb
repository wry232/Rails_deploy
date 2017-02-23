class SecretsController < ApplicationController
  before_action :require_login, only: [:new_secret, :delete] # only the methods listed will require the require_login method from application_controller.rb
  def index
    @secrets = Secret.all
  end
  def new_secret
    User.find(session[:user_id]).secrets.create(content: params[:"New Secret"])
    redirect_to "/users/#{:id}"
  end
  def delete
    if Secret.find(params[:id]).user == User.find(session[:user_id])
      Secret.find(params[:id]).destroy
    end
      redirect_to "/users/#{session[:user_id]}"
  end
  def delete_from_index
    Secret.find(params[:sid]).destroy
    redirect_to "/secrets"
  end
end
