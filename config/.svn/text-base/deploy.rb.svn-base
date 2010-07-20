set :admin_runner, "jcomponent" 

set :application, "jobmia.com" 
set :user, "jcomponent" 
set :local_repository, "http://ajay@208.75.87.100/svn/jobmia/trunk" 
set :repository, "file:///home/jcomponent/repositories/jobmia/trunk" 
set :runner, user

# If you aren't deploying to /u/apps/#{application} on the target 
# servers (which is the default), you can specify the actual location 
# via the :deploy_to variable: 
# set :deploy_to, "/var/www/#{application}" 

set :port, 8434 
set :deploy_to, "/home/jcomponent/public_html/#{application}" 

# If you aren't using Subversion to manage your source code, specify 
# your SCM below: 
# set :scm, :subversion 

role :app, application 
role :web, application 
role :db, application , :primary => true 

set :db_user, "root" 
set :db_pass, "ajatha"

namespace :images_symlink do
  task :default do
    run "rm -Rf #{release_path}/tmp/cache && ln -s #{shared_path}/cache #{release_path}/tmp/cache" 
    run "rm -Rf #{release_path}/public/resume && ln -s #{shared_path}/resume #{release_path}/public/resume" 
  end
end

namespace :passenger do 
  desc "Restart Application" 
  task :restart do 
    run "touch #{current_path}/tmp/restart.txt" 
  end 
end 

namespace :deploy do 
  desc "Create asset packages for production" 
  task :after_update_code, :roles => [:web] do 
    run "cd #{release_path} && rake RAILS_ENV=production asset:packager:build_all"
  end 
end  
  
after "deploy", "deploy:cleanup" 
after "deploy:migrations", "deploy:cleanup"

after "deploy:symlink", "images_symlink"
after "deploy", :clear_cache

namespace :clear_cache do
  desc "Clear cache"
  task :default do
    run "cd #{release_path} && rake RAILS_ENV=production tmp:cache:clear"
  end
end

after "deploy", "passenger:restart"