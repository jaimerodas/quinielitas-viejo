require 'test_helper'

class MatchPoolsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get match_pools_index_url
    assert_response :success
  end

  test "should get new" do
    get match_pools_new_url
    assert_response :success
  end

  test "should get create" do
    get match_pools_create_url
    assert_response :success
  end

  test "should get edit" do
    get match_pools_edit_url
    assert_response :success
  end

  test "should get update" do
    get match_pools_update_url
    assert_response :success
  end

  test "should get destroy" do
    get match_pools_destroy_url
    assert_response :success
  end

end
