class UsersController < ApplicationController
  before_action :require_login, except: [:new_user, :register, :sessions, :login] # every method here except those listed will requre login which is verfied by the require_login method in application_controller.rb
  before_action :require_correct_user, only: [:show, :edit_user, :update, :delete] #
  def sessions
    if session[:user_id]
      redirect_to "/users/#{session[:user_id]}"
    end
  end
  def login
    # if session[:user_id]
    #   redirect_to "/users/#{session[:user_id]}"
    if (@user = User.find_by(email: params[:Email])) && @user.authenticate(params[:Password]) # use bcrypt authenticate method to check entered password
        session[:user_id] = @user.id # use session key name user_id or something else that's not just id because id is what named routes uses. Might work but might as well make them different
        redirect_to "/users/#{@user.id}"
    else
      flash[:error] = "Invalid Email/Password combination."
      redirect_to '/sessions/new'
    end
  end
  def show
    # if !session[:user_id] || (params[:id].to_i != session[:user_id]) # don't need anymore. Replaced with before_action :require_correct_user
    #   redirect_to "/sessions/new"
    # elsif !session[:user_id]
    #   redirect_to "/sessions/new"
    # else
    @user = User.find(params[:id])
    # end
  end
  def logout
    session[:user_id] = nil
    redirect_to '/sessions/new'
  end
  def new_user
    if session[:user_id]
      redirect_to "/users/#{session[:user_id]}"
    end
  end
  def register
    @user = User.new(name: params[:Name], email: params[:Email], password: params[:Password])
    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      redirect_to "/users/#{@user.id}"
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to "/users/new"
    end
  end
  def edit_user
    # if !session[:user_id] || (params[:id].to_i != session[:user_id]) # replaced by before_action :require_correct_user
    #   redirect_to "/sessions/new"
    # end
    @user = User.find(session[:user_id])
  end
  def update
    @user = User.update(name: params[:Name], email: params[:Email], password: params[:Password])
    redirect_to "/users/#{params[:id]}"
  end
  def delete
    # if (params[:id].to_i == session[:user_id]) # replaced by before_action :require_correct_user
    User.find(params[:id]).destroy
    session[:user_id] = nil
    redirect_to '/sessions/new'
    # else
    #   redirect_to 'sessions/new'
    # end
  end
end
