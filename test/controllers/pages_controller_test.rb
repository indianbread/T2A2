require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get indexc" do
    get pages_indexc_url
    assert_response :success
  end

end
