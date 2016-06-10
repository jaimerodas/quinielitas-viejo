require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get rules" do
    get static_pages_rules_url
    assert_response :success
  end

end
