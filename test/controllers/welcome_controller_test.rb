require 'test_helper'

class WelcomeControllerTest < ActionDispatch::IntegrationTest

  setup do
    user = User.create!(email:"test@gmail.com", 
    password: "test", firstname: "Tester", 
    lastname: "Tester", temp_id: 1, f_temp_id: 1)
    manual_sign_in_as(user)
  end

  test "should get index" do
    get "/"
    assert_response :success
    assert_select "title", "Home | Pollen - Plant a Wish"
  end

  test "should get profile" do
    get "/profile"
    assert_response :success
    assert_select "title", "Profile | Pollen - Plant a Wish"
  end

  test "should get feed" do
    get "/feed"
    assert_response :success
    assert_select "title", "Journal Feed | Pollen - Plant a Wish"
  end

  #test "should get forum" do
    #get "/forum"
    #assert_response :success
  #end

end