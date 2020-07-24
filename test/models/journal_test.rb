require 'test_helper'

class JournalTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(email:"test@gmail.com", 
        password: "test", firstname: "Tester", 
        lastname: "Tester", temp_id: 1, f_temp_id: 1)
    @journal = @user.journals.build(title:"test journal")
    @journal.save
  end

  test "should be valid" do
    assert @journal.valid?
  end

  test "title should be present" do
    @journal.title = ""
    assert_not @journal.valid?
  end

  test "title is too long" do
    @journal.title = "a" * 26
    assert_not @journal.valid?
  end

  test "journal has no user" do
    @journal.user = nil
    assert_not @journal.valid?
  end

  test "journal should be destroyed with user" do
    assert_difference 'Journal.count', -1 do 
      @user.destroy
    end
  end

  #default_scope -> { order(title: :asc) }
end
