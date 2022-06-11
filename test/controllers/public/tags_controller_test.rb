require "test_helper"

class Public::TagsControllerTest < ActionDispatch::IntegrationTest
  test "should get tag_posts" do
    get public_tags_tag_posts_url
    assert_response :success
  end
end
