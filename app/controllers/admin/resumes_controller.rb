class Admin::ResumesController < ApplicationController 
  layout "admin"
  active_scaffold :resume
end