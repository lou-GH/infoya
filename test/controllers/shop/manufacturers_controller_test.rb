require "test_helper"

class Shop::ManufacturersControllerTest < ActionDispatch::IntegrationTest
  test "should get unsubscribe" do
    get shop_manufacturers_unsubscribe_url
    assert_response :success
  end

  test "should get withdraw" do
    get shop_manufacturers_withdraw_url
    assert_response :success
  end

  test "should get show" do
    get shop_manufacturers_show_url
    assert_response :success
  end

  test "should get edit" do
    get shop_manufacturers_edit_url
    assert_response :success
  end

  test "should get update" do
    get shop_manufacturers_update_url
    assert_response :success
  end
end
