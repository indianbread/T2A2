require 'test_helper'

class UserInfosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_infos_index_url
    assert_response :success
  end

  test "should get show" do
    get user_infos_show_url
    assert_response :success
  end

  test "should get edit" do
    get user_infos_edit_url
    assert_response :success
  end

  test "should get destroy" do
    get user_infos_destroy_url
    assert_response :success
  end

end
