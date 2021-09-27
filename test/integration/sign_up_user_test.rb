require "test_helper"

class SignUpUserTest < ActionDispatch::IntegrationTest
  setup do
    @admin_user = User.create(username: 'johndoe', email: "johndoe@example.com",
                              password: 'password', admin: true)
    sign_in_as(@admin_user)
      
  end

  test "get sign up form and create user" do

    get "/signup"
    assert_response :success
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { username: "test", email: "test@example.com", 
                                              password: "password"} }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "test", response.body
  end

  test "get sign up form and reject invalid user submission: No user" do
    get "/signup"
    assert_response :success
    assert_no_difference 'User.count' do
      post users_path, params: { user: { username: "", email: "test@example.com", 
                                        password: "password"} }
    end
    assert_match "erros", response.body
    # it is better to use assert_select 'html code especific for alert'
    # becuase if you change the error message, you the test will not pass
  end
end
