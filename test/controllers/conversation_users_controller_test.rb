require 'test_helper'

class ConversationUsersControllerTest < ActionController::TestCase
  setup do
    @conversation_user = conversation_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:conversation_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create conversation_user" do
    assert_difference('ConversationUser.count') do
      post :create, conversation_user: { conversation_id: @conversation_user.conversation_id, user_id: @conversation_user.user_id }
    end

    assert_redirected_to conversation_user_path(assigns(:conversation_user))
  end

  test "should show conversation_user" do
    get :show, id: @conversation_user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @conversation_user
    assert_response :success
  end

  test "should update conversation_user" do
    patch :update, id: @conversation_user, conversation_user: { conversation_id: @conversation_user.conversation_id, user_id: @conversation_user.user_id }
    assert_redirected_to conversation_user_path(assigns(:conversation_user))
  end

  test "should destroy conversation_user" do
    assert_difference('ConversationUser.count', -1) do
      delete :destroy, id: @conversation_user
    end

    assert_redirected_to conversation_users_path
  end
end
