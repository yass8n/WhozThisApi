require 'test_helper'

class BlockedUsersControllerTest < ActionController::TestCase
  setup do
    @blocked_user = blocked_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:blocked_users)
  end

  test "should create blocked_user" do
    assert_difference('BlockedUser.count') do
      post :create, blocked_user: { blocked_id: @blocked_user.blocked_id, user_id: @blocked_user.user_id }
    end

    assert_response 201
  end

  test "should show blocked_user" do
    get :show, id: @blocked_user
    assert_response :success
  end

  test "should update blocked_user" do
    put :update, id: @blocked_user, blocked_user: { blocked_id: @blocked_user.blocked_id, user_id: @blocked_user.user_id }
    assert_response 204
  end

  test "should destroy blocked_user" do
    assert_difference('BlockedUser.count', -1) do
      delete :destroy, id: @blocked_user
    end

    assert_response 204
  end
end
