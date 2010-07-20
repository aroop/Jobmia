class Admin::UsersController < ApplicationController
  before_filter :admin_required
  layout "admin"
  active_scaffold :user do |config|
    config.columns = [:login, :first_name, :last_name, :email, :resumes, :state, :is_admin]
  end
end