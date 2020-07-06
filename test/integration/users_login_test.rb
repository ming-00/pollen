require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  test "login with invalid information" do
    get "/sign_in"
    assert_template "sessions/new"
    post "/session", 
      params: { session: { email: "", password: "" } }
    assert_template 'sessions/new'
    assert_not flash.empty?
  end

  test "login with valid information then logout" do
    @user = User.create!(email:"test@gmail.com", 
      password: "test", firstname: "Tester", 
      lastname: "Tester", temp_id: 1, f_temp_id: 1)
    get "/sign_in"
    assert_template "sessions/new"
    manual_sign_in_as(@user)
    #assert is_logged_in?
    assert_redirected_to root_path
    follow_redirect!
    assert_template 'welcome/index'
    assert flash.empty?

    delete "/sign_out"
    assert_not is_logged_in?
    assert_redirected_to "/sign_in"

    delete "/sign_out"
    assert_redirected_to "/sign_in"
  end

  test "valid signup information" do
    get "/sign_up"
    assert_difference 'User.count', 1 do
      post users_path, params: {
        user: { 
        firstname:  "Test",
        lastname: "Test",
        email: "test@gmail.com",
        password: "test",
        temp_id: 1, f_temp_id:1
        }
      }
      follow_redirect!
    end
    assert_template "welcome/index"
    #assert is_logged_in?
    assert_not flash.empty?
    get "/profile"
    assert flash.empty?
  end

end