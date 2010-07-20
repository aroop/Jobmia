# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  include HoptoadNotifier::Catcher
  #protect_from_forgery
  
  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_jobmia_session_id'
  
  include AuthenticatedSystem
  
  filter_parameter_logging :password
  
  def admin_menu
    @admin_menu ||= MainMenu.new("root") do |root|
      root.add_child MainMenu.new("Users", admin_users_path)
      root.add_child MainMenu.new("Resumes", admin_resumes_path)
    end
  end
  
  def main_navigation
  	@main_navigation ||= MainMenu.new("root") do |root|
  	  if logged_in?
  	    resume = current_user.active_resume
		    root.add_child MainMenu.new("Resumes", resumes_path)
		    root.add_child MainMenu.new("Builder", edit_resume_path(1)) do |s|
		      if resume
		        s.add_child MainMenu.new("Doc", {:controller => 'resumes', :action => 'download', :id => resume, :type => 'doc'})
		        s.add_child MainMenu.new("PDF", {:controller => 'resumes', :action => 'download', :id => resume, :type => 'pdf'})
		        s.add_child MainMenu.new("RTF", {:controller => 'resumes', :action => 'download', :id => resume, :type => 'rtf'})
		        s.add_child MainMenu.new("HTML", {:controller => 'resumes', :action => 'download', :id => resume, :type => 'html'})
		        s.add_child MainMenu.new("TXT", {:controller => 'resumes', :action => 'download', :id => resume, :type => 'txt'})
	        end
		    end
		    root.add_child MainMenu.new("Designer", designer_resumes_path)
		    root.add_child MainMenu.new("Distribution", distribution_resumes_path)
		    root.add_child MainMenu.new("Promotion", promotion_resumes_path)	      
	    else
		    root.add_child MainMenu.new("Home", root_path)
		    root.add_child MainMenu.new("Builder", builder_path)
		    root.add_child MainMenu.new("Designer", designer_path)
		    root.add_child MainMenu.new("Distribution", distributer_path)
		    root.add_child MainMenu.new("Promotion", promotion_path)	      
	    end
    end
  end
  
  ActiveScaffold.set_defaults do |config| 
    config.ignore_columns.add [:created_at, :updated_at, :lock_version] 
  end
  
  protected
  def admin_required
    (logged_in? && current_user.send('is_admin')) || admin_denied
  end
  
  def admin_denied
    respond_to do |format|
      format.html do
        store_location
        flash[:notice] = 'You must be an admin to do that.'
        redirect_to new_session_path
      end
    end
  end

end