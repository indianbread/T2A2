require 'test_helper'

class OrderLinesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get order_lines_index_url
    assert_response :success
  end

  test "should get new" do
    get order_lines_new_url
    assert_response :success
  end

  test "should get show" do
    get order_lines_show_url
    assert_response :success
  end

  test "should get edit" do
    get order_lines_edit_url
    assert_response :success
  end

  test "should get destroy" do
    get order_lines_destroy_url
    assert_response :success
  end

end
