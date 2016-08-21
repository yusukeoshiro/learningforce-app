require 'test_helper'

class PageControllerTest < ActionController::TestCase
  test "should get send_invite" do
    get :send_invite
    assert_response :success
  end

end
