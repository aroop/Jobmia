require File.dirname(__FILE__) + '/../test_helper'
require 'topics_controller'

# Re-raise errors caught by the controller.
class TopicsController; def rescue_action(e) raise e end; end

class TopicsControllerTest < Test::Unit::TestCase
  fixtures :topics

  def setup
    @controller = TopicsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:topics)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_topic
    assert_difference('Topic.count') do
      post :create, :topic => { }
    end

    assert_redirected_to topic_path(assigns(:topic))
  end

  def test_should_show_topic
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end

  def test_should_update_topic
    put :update, :id => 1, :topic => { }
    assert_redirected_to topic_path(assigns(:topic))
  end

  def test_should_destroy_topic
    assert_difference('Topic.count', -1) do
      delete :destroy, :id => 1
    end

    assert_redirected_to topics_path
  end
end
