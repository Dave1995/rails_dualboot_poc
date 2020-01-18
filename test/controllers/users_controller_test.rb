require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      if Rails::VERSION::MAJOR < 5
        post :create, user: { email: "test@test.com", password: 'secret', password_confirmation: 'secret' }
      else
        post :create, params: { user: { email: "test@test.com", password: 'secret', password_confirmation: 'secret' }}
      end
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    if Rails::VERSION::MAJOR < 5
      get :show, id: @user
    else
      get :show, params: { id: @user }
    end
    assert_response :success
  end

  test "should get edit" do
    if Rails::VERSION::MAJOR < 5
      get :edit, id: @user
    else
      get :edit, params: { id: @user }
    end
    assert_response :success
  end

  test "should update user" do
    if Rails::VERSION::MAJOR < 5
      patch :update, id: @user, user: { email: @user.email, password: 'secret', password_confirmation: 'secret' }
    else
      patch :update, params: { id: @user, user: { email: @user.email, password: 'secret', password_confirmation: 'secret' }}
    end
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      if Rails::VERSION::MAJOR < 5
        delete :destroy, id: @user
      else
        delete :destroy, params: { id: @user }
      end
    end

    assert_redirected_to users_path
  end
end
