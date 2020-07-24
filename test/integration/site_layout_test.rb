require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  setup do
    user = User.create!(email:"test@gmail.com", 
    password: "test", firstname: "Tester", 
    lastname: "Tester", temp_id: 1, f_temp_id: 1)
    manual_sign_in_as(user)
  end

  test "layout links" do
    get root_path
    assert_template "welcome/index"
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", feed_path
    assert_select "a[href=?]", forum_path
    assert_select "a[href=?]", profile_path
  end
end
