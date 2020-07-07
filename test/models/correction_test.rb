require 'test_helper'

class CorrectionTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(email: "test@gmail.com", 
      password: "test", firstname: "Tester", 
      lastname: "Tester", temp_id: 1, f_temp_id: 1)
    @journal = @user.journals.build(title: "test journal")
    @journal.save
    @entry = @journal.entries.build(title: "test entry",
      content:"a"*100)
    @entry.save
    @correction = @entry.corrections.create(content: "a" * 10)
    @correction.user = @user
    @correction.save
  end

  test "should be valid and correct is false by default" do
    assert @correction.valid?
    assert_not @correction.correct?
  end

  test "no user assigned" do
    @correction.user = nil
    assert_not @correction.valid?
  end

  test "no entry assigned" do
    @correction.entry = nil
    assert_not @correction.valid?
  end

  test "content is blank" do
    @correction.content = ""
    assert_not @correction.valid?
  end

  #default_scope -> { order(created_at: :desc) }
end