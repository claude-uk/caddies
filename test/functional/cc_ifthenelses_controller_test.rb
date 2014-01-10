require 'test_helper'

class CcIfthenelsesControllerTest < ActionController::TestCase
  setup do
    @cc_ifthenelse = cc_ifthenelses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cc_ifthenelses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cc_ifthenelse" do
    assert_difference('CcIfthenelse.count') do
      post :create, :cc_ifthenelse => @cc_ifthenelse.attributes
    end

    assert_redirected_to cc_ifthenelse_path(assigns(:cc_ifthenelse))
  end

  test "should show cc_ifthenelse" do
    get :show, :id => @cc_ifthenelse.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @cc_ifthenelse.to_param
    assert_response :success
  end

  test "should update cc_ifthenelse" do
    put :update, :id => @cc_ifthenelse.to_param, :cc_ifthenelse => @cc_ifthenelse.attributes
    assert_redirected_to cc_ifthenelse_path(assigns(:cc_ifthenelse))
  end

  test "should destroy cc_ifthenelse" do
    assert_difference('CcIfthenelse.count', -1) do
      delete :destroy, :id => @cc_ifthenelse.to_param
    end

    assert_redirected_to cc_ifthenelses_path
  end
end
