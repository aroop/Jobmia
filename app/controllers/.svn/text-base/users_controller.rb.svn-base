class UsersController < ApplicationController
  
  include DownloadHelper
  
  # Protect these actions behind an admin login
  before_filter :admin_required, :only => [:suspend, :unsuspend, :purge]
  
  # render new.rhtml
  def new
    render :layout => 'pagessmall'
  end
  
  def show
    @user = User.find_by_login(params[:id])
    if @user
      unless @user.active_resume.nil?
        @resume_content = get_formatted_resume(@user.active_resume, 'html', (logged_in? && @user == current_user))
      else
        @resume_content = "No public resume exists for this user"
      end
    else
      @resume_content = "Unable to find the specified user"
    end
  end
  
  def index
    #redirect_to :controller => "profiles", :action => "index"
  end

  def create
    cookies.delete :auth_token
    # protects against session fixation attacks, wreaks havoc with 
    # request forgery protection.
    # uncomment at your own risk
    # reset_session
    @user = User.new(params[:user])
    @user.register! if @user.valid?
    if @user.errors.empty?
      flash[:notice] = "Thanks for signing up! Please check your email to activate your account before logging in."
      redirect_back_or_default('/')
    else
      render :action => 'new', :layout => 'pagessmall'
    end
  end

  def activate
    self.current_user = params[:activation_code].blank? ? false : User.find_by_activation_code(params[:activation_code])
    if logged_in? && !current_user.active?
      current_user.activate!
      flash[:notice] = "Signup complete!"
    end
    redirect_back_or_default('/')
  end

  def suspend
    @user.suspend! 
    redirect_to users_path
  end

  def unsuspend
    @user.unsuspend! 
    redirect_to users_path
  end

  def destroy
    current_user.delete!    
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "Your profile has been successfully deleted."
    redirect_back_or_default('/')
  end

  def purge
    @user.destroy
    redirect_to users_path
  end
  
  def account
    if logged_in?
      @user = current_user
      render :layout => 'promotion'
    else
      flash[:error] = 'You are not logged in - please login first'
      redirect_to "/login"
    end
  end
  
  def update
    @user = current_user
    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = "Profile updated successfully"
        format.html { redirect_to :action => "account" }
        format.xml  { head :ok }
      else
        format.html { render :action => "account" }
        format.xml  { render :xml => current_user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # action to perform when the user wants to change their password
  def change_password
    return unless request.post?
    if User.authenticate(current_user.login, params[:old_password])
      if (params[:password] == params[:password_confirmation])
        current_user.password_confirmation = params[:password_confirmation]
        current_user.password = params[:password]
        if current_user.save
          flash[:notice] = "Password updated successfully"
        else
          flash[:error] = "Password not changed"
        end
      else
        flash[:error] = "New password mismatch"
        @old_password = params[:old_password]
      end
    else
      flash[:error] = "Old password incorrect"
    end
    redirect_to account_url
  end

  # action to perform when the users clicks forgot_password
  def forgot_password
    return unless request.post?
    if params[:email]
      @user = User.find_by_email(params[:email])
    end
    unless @user
      @user = User.find_by_login(params[:login])
    end
    if @user
      @user.forgot_password
      @user.save
      flash[:notice] = "A password reset link has been sent to your email address"
    else
      flash[:error] = "Could not find your username / email in my system"
    end
    redirect_to login_url
  end

  # action to perform when the user resets the password
  def reset_password
    @user = User.find_by_password_reset_code(params[:code])
    return if @user unless params[:user]

    if ((params[:user][:password] && params[:user][:password_confirmation]))
      self.current_user = @user # for the next two lines to work
      current_user.password_confirmation = params[:user][:password_confirmation]
      current_user.password = params[:user][:password]
      @user.reset_password
      flash[:notice] = current_user.save ? "Password reset successfully" : "Unable to reset password"
      redirect_back_or_default('/')
    else
      flash[:alert] = "Password mismatch"
    end
  end  

protected
  def find_user
    @user = User.find(params[:id])
  end

end