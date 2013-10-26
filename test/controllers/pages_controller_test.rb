require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  
  test "should get index" do
    get :index
    assert_response :success
  end

  # test "page should say app data" do
  #   assert page contains "app data"
  # end
end
