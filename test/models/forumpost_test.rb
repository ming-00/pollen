require 'test_helper'

class ForumpostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = users(:bigboi)
    @forumpost = @user.microposts.build(content: "Lorem ipsum")
  end

  test "should be valid" do
    assert @forumpost.valid?
  end

  test "user id should be present" do
    @forumpost.user_id = nil
    assert_not @forumpost.valid?
  end
end
