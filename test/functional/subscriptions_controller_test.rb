require 'test_helper'

class SubscriptionsControllerTest < ActionController::TestCase
  test "should get unsubscribe" do
    get :unsubscribe
    assert_response :success
  end

end
