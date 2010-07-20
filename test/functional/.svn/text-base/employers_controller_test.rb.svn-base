require File.dirname(__FILE__) + '/../test_helper'
require 'employers_controller'

# Re-raise errors caught by the controller.
class EmployersController; def rescue_action(e) raise e end; end

class EmployersControllerTest < Test::Unit::TestCase
  fixtures :employers

  def setup
    @controller = EmployersController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:employers)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_employer
    assert_difference('Employer.count') do
      post :create, :employer => { }
    end

    assert_redirected_to employer_path(assigns(:employer))
  end

  def test_should_show_employer
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end

  def test_should_update_employer
    put :update, :id => 1, :employer => { }
    assert_redirected_to employer_path(assigns(:employer))
  end

  def test_should_destroy_employer
    assert_difference('Employer.count', -1) do
      delete :destroy, :id => 1
    end

    assert_redirected_to employers_path
  end
end
