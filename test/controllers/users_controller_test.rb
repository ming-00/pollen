require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    user = User.create!(email:"test@gmail.com", 
    password: "test", firstname: "Tester", 
    lastname: "Tester", temp_id: 1, f_temp_id: 1)
    manual_sign_in_as(user)
  end

end
