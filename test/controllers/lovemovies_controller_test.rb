require 'test_helper'

class LovemoviesControllerTest < ActionController::TestCase
  setup do
    @lovemovie = lovemovies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lovemovies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lovemovie" do
    assert_difference('Lovemovie.count') do
      post :create, lovemovie: { loveword: @lovemovie.loveword }
    end

    assert_redirected_to lovemovie_path(assigns(:lovemovie))
  end

  test "should show lovemovie" do
    get :show, id: @lovemovie
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lovemovie
    assert_response :success
  end

  test "should update lovemovie" do
    patch :update, id: @lovemovie, lovemovie: { loveword: @lovemovie.loveword }
    assert_redirected_to lovemovie_path(assigns(:lovemovie))
  end

  test "should destroy lovemovie" do
    assert_difference('Lovemovie.count', -1) do
      delete :destroy, id: @lovemovie
    end

    assert_redirected_to lovemovies_path
  end
end
