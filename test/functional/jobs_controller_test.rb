require File.dirname(__FILE__) + '/../test_helper'
require 'jobs_controller'

# Re-raise errors caught by the controller.
class JobsController; def rescue_action(e) raise e end; end

class JobsControllerTest < Test::Unit::TestCase
  fixtures :jobs

  def setup
    @controller = JobsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:jobs)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_job
    old_count = Job.count
    post :create, :job => { }
    assert_equal old_count+1, Job.count
    
    assert_redirected_to job_path(assigns(:job))
  end

  def test_should_show_job
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_job
    put :update, :id => 1, :job => { }
    assert_redirected_to job_path(assigns(:job))
  end
  
  def test_should_destroy_job
    old_count = Job.count
    delete :destroy, :id => 1
    assert_equal old_count-1, Job.count
    
    assert_redirected_to jobs_path
  end
end
