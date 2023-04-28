require "test_helper"

class AuthControllerTest < ActionDispatch::IntegrationTest
  test "should get login" do
    get auth_login_url
    assert_response :success
  end

  test "should get signup" do
    get auth_signup_url
    assert_response :success
  end

  test "should get confirm" do
    get auth_confirm_url
    assert_response :success
  end

  test "should get forgot" do
    get auth_forgot_url
    assert_response :success
  end

  test "should get reset_password" do
    get auth_reset_password_url
    assert_response :success
  end
end
