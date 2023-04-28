require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get evaluate_order" do
    get orders_evaluate_order_url
    assert_response :success
  end

  test "should get is_confirmed" do
    get orders_is_confirmed_url
    assert_response :success
  end

  test "should get is_done" do
    get orders_is_done_url
    assert_response :success
  end
end
