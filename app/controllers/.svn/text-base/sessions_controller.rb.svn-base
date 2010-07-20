# This controller handles the login/logout function of the site.
class SessionsController < ApplicationController
  layout 'pagessmall'
  # render new.rhtml
  def new
  end
  
  def index
  	render :layout => 'pages'
	end
	
  def create
    self.current_user = User.authenticate(params[:login], params[:password])
    if logged_in?
      if params[:remember_me] == "1"
        current_user.remember_me unless current_user.remember_token?
        cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
      end
      current_user.save_login_time
      flash[:notice] = "Logged in successfully"
      redirect_to resumes_path
    else
      flash[:error] = "Your username or password is incorrect."
      render :action => 'new'
    end
  end

  def destroy
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_back_or_default('/')
  end
  
end