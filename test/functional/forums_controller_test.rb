require File.dirname(__FILE__) + '/../test_helper'
require 'forums_controller'

# Re-raise errors caught by the controller.
class ForumsController; def rescue_action(e) raise e end; end

class ForumsControllerTest < Test::Unit::TestCase
  fixtures :forums

  def setup
    @controller = ForumsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:forums)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_forum
    assert_difference('Forum.count') do
      post :create, :forum => { }
    end

    assert_redirected_to forum_path(assigns(:forum))
  end

  def test_should_show_forum
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end

  def test_should_update_forum
    put :update, :id => 1, :forum => { }
    assert_redirected_to forum_path(assigns(:forum))
  end

  def test_should_destroy_forum
    assert_difference('Forum.count', -1) do
      delete :destroy, :id => 1
    end

    assert_redirected_to forums_path
  end
end
