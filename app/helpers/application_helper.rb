# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def user_is_admin?
    session[:user_id] && (user = User.find(session[:user_id])) && user.is_admin
  end  
  
  def header_menu(name, path)
    link_to name, path, :class => current_page?(path)? "selected" : ""
  end
  
  def controller_is(*attrs) # <= check for one or multiple controllers
    attrs.collect{|attr| attr.to_s}.include?(controller.controller_name)
  end

end