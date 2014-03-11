require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  test "should get invitation" do
    get :invitation
    assert_response :success
  end

end
