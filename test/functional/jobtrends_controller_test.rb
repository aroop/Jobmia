require File.dirname(__FILE__) + '/../test_helper'
require 'jobtrends_controller'

# Re-raise errors caught by the controller.
class JobtrendsController; def rescue_action(e) raise e end; end

class JobtrendsControllerTest < Test::Unit::TestCase
  def setup
    @controller = JobtrendsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
