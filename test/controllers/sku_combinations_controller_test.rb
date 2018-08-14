require 'test_helper'

class SkuCombinationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get sku_combinations_index_url
    assert_response :success
  end

  test "should get show" do
    get sku_combinations_show_url
    assert_response :success
  end

  test "should get new" do
    get sku_combinations_new_url
    assert_response :success
  end

end
