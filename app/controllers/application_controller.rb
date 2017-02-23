class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user # this makes the current_user method available in all view templates
  def require_login # this replaces the checks I was doing in each individual method. Nice!
    redirect_to '/sessions/new' if session[:user_id] == nil
  end
  def require_correct_user # this replaces the checks I was doing in each individual method. Nice!
    if !(user = User.find_by_id(params[:id])) # platform had method find which throws up an exception if it does not exist. find_by_id works better here because it does not throw exception and just returns nil if id doesn't exist
      redirect_to "/sessions/new" # better to have above conditional in case someone tried a path with non-existant user id. Strange that long numbers and only letters redirect and show correct URL with user's id. However, correnct id followed by letters does not change URL back to just id
    elsif user != current_user
      redirect_to "/users/#{current_user.id}"
    end
  end
end
