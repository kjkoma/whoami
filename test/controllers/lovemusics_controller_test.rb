require 'test_helper'

class LovemusicsControllerTest < ActionController::TestCase
  setup do
    @lovemusic = lovemusics(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lovemusics)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lovemusic" do
    assert_difference('Lovemusic.count') do
      post :create, lovemusic: { loveword: @lovemusic.loveword }
    end

    assert_redirected_to lovemusic_path(assigns(:lovemusic))
  end

  test "should show lovemusic" do
    get :show, id: @lovemusic
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lovemusic
    assert_response :success
  end

  test "should update lovemusic" do
    patch :update, id: @lovemusic, lovemusic: { loveword: @lovemusic.loveword }
    assert_redirected_to lovemusic_path(assigns(:lovemusic))
  end

  test "should destroy lovemusic" do
    assert_difference('Lovemusic.count', -1) do
      delete :destroy, id: @lovemusic
    end

    assert_redirected_to lovemusics_path
  end
end
