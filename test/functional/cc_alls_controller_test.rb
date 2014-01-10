require 'test_helper'

class CcAllsControllerTest < ActionController::TestCase
  setup do
    @cc_all = cc_alls(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cc_alls)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cc_all" do
    assert_difference('CcAll.count') do
      post :create, :cc_all => @cc_all.attributes
    end

    assert_redirected_to cc_all_path(assigns(:cc_all))
  end

  test "should show cc_all" do
    get :show, :id => @cc_all.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @cc_all.to_param
    assert_response :success
  end

  test "should update cc_all" do
    put :update, :id => @cc_all.to_param, :cc_all => @cc_all.attributes
    assert_redirected_to cc_all_path(assigns(:cc_all))
  end

  test "should destroy cc_all" do
    assert_difference('CcAll.count', -1) do
      delete :destroy, :id => @cc_all.to_param
    end

    assert_redirected_to cc_alls_path
  end
end
