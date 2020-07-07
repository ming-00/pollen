require 'test_helper'

class EntryTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(email: "test@gmail.com", 
      password: "test", firstname: "Tester", 
      lastname: "Tester", temp_id: 1, f_temp_id: 1)
    @journal = @user.journals.build(title: "test journal")
    @journal.save
    @entry = @journal.entries.build(title: "test entry",
      content:"a"*100)
    @entry.save
  end

  test "should be valid" do
    assert @entry.valid?
  end

  test "title is blank" do
    @entry.title = ""
    assert_not @entry.valid?
  end

  test "title is too long" do
    @entry.title = "a" * 71
    assert_not @entry.valid?
  end

  test "content is blank" do
    @entry.content = ""
    assert_not @entry.valid?
  end

  test "content is too long" do
    @entry.content = "a" * 2001
    assert_not @entry.valid?
  end

  test "entry has no journal" do
    @entry.journal = nil
    assert_not @entry.valid?
  end
  
  #default_scope -> { order(created_at: :desc) }
end
