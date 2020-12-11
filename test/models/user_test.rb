require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end


  test "Should save user" do
    u = User.new
    u.email = "valid.email@example.com"
    u.name = "Valid User"
    u.password = "pass123"
    assert u.save
  end

  test "should not save user with existing email" do
    u = User.new
    u.name  = "Duplicate David"
    u.email = users(:normal_user).email
    u.password = "123"
    assert_not u.save, "Could save user with duplciate email"
  end

  test "should not save user without name" do
    u = User.new
    u.email = "test@example.com"
    u.password = "123"
    assert_not u.save, "Could save user without name"
  end

  test "should not save user without email" do
    u = User.new
    u.name = "Test Elek"
    u.password = "123"
    assert_not u.save, "Could save user without email"
  end

  test "should not save user with incorrect password confirmation" do
    u = User.new(name:"u",email:"test@example.net",password:"123456",password_confirmation:"not the same")
    assert_not u.save
  end

  test "should encrypt password" do
    u = User.new(name: "TU", email: "test&test.com", password: "123456")
    assert u.save

    saved = User.find u.id
    assert_nil saved.password, "Password filed is not nil"
  end

end
