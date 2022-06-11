require "test_helper"

class TagsControllerTest < ActionDispatch::IntegrationTest
  test "should get tag_posts" do
    get tags_tag_posts_url
    assert_response :success
  end
end
