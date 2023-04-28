require "test_helper"

class OrderDishControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get order_dish_index_url
    assert_response :success
  end

  test "should get show" do
    get order_dish_show_url
    assert_response :success
  end

  test "should get update" do
    get order_dish_update_url
    assert_response :success
  end

  test "should get destroy" do
    get order_dish_destroy_url
    assert_response :success
  end
end
