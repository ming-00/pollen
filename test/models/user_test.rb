require 'test_helper'

class UserTest < ActiveSupport::TestCase
    def setup
        @user = User.create!(email:"test@gmail.com", 
            password: "test", firstname: "Tester", 
            lastname: "Tester", temp_id: 1, f_temp_id: 1)
    end

    test "should be valid" do
        assert @user.valid?
    end

    test "firstname should be present" do
        @user.firstname = "     "
        assert_not @user.valid?
    end

    test "lastname should be present" do
        @user.lastname = "     "
        assert_not @user.valid?
    end

    test "email should be present" do
        @user.email = "     "
        assert_not @user.valid?
    end

    test "firstname should not be too long" do
        @user.firstname = "a" * 26
        assert_not @user.valid?
    end
    
    test "lastname should not be too long" do
        @user.lastname = "a" * 26
        assert_not @user.valid?
    end

    test "firstname should not have numbers" do
        @user.firstname = "1" * 5
        assert_not @user.valid?
    end

    test "lastname should not have numbers" do
        @user.firstname = "1" * 5
        assert_not @user.valid?
    end

    test "email validation should accept valid addresses" do
        valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                             first.last@foo.jp alice+bob@baz.cn]
        valid_addresses.each do |valid_address|
          @user.email = valid_address
          assert @user.valid?, "#{valid_address.inspect} should be valid"
        end
    end

    test "email addresses should be unique" do
        duplicate_user = @user.dup
        duplicate_user.email = @user.email.upcase
        @user.save
        assert_not duplicate_user.valid?
    end

    test "password should be present (nonblank)" do
        @user.password = " " * 6
        assert_not @user.valid?
    end

    test "password should have a minimum length" do
        @user.password = "a" * 3
        assert_not @user.valid?
    end
end