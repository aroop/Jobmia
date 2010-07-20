ActionController::Routing::Routes.draw do |map|
	
	map.with_options :controller => "pages" do |main| 
    main.root :action => "index"
    main.builder 'builder', :action => "builder"
    main.designer 'designer', :action => "designer"
    main.distributer 'distributer', :action => "distributer"
    main.promotion 'promotion', :action => "promotion"

    main.tour 'tour', :action => "tour"
    main.about 'about', :action => "about"
    main.careers 'careers', :action => "careers"
    main.press 'press',  :action => "press"
    main.privacy 'privacy',  :action => "privacy"
    main.uagreement 'uagreement', :action => "uagreement"
  end
  
	map.resources :resumes,
	    :member => {:make_active => :post, :save_entry => :post, :remove_section => :delete, 
	      :remove_entry => :delete, :add_entry => :post, :add_section => :post, :set_style => :post, :save_options => :post, 
	      :order_section => :post, :order_entries => :post, :preview => :get}, 
	    :collection => {:designer => :get, :distribution => :get, :promotion => :get, :sendemail => :post, :download => :get}
	
	map.resources :users, :member => {
    :suspend => :put,
    :unsuspend => :put,
    :purge => :delete
  }
  
  map.namespace :admin do |admin|
   # Directs /admin/users/* to Admin::UsersController (app/controllers/admin/users_controller.rb)
   admin.resources :users, :active_scaffold => true
   admin.resources :resumes, :active_scaffold => true
  end

  map.resource :session
  
  map.with_options :controller => "sessions" do |main| 
    main.login '/login', :action => 'new'
    main.logout '/logout', :action => 'destroy'
  end
  
  map.with_options :controller => "users" do |main| 
    main.activate '/activate/:activation_code', :action => 'activate'
    main.signup '/signup', :action => 'new'
    main.forgot_password '/forgot_password', :action => 'forgot_password'
    main.reset_password '/reset_password/:code', :action => 'reset_password'
    main.account '/account', :action => 'account'
  end

end