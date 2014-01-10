require 'test_helper'

class QiRdasControllerTest < ActionController::TestCase
  setup do
    @qi_rda = qi_rdas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:qi_rdas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create qi_rda" do
    assert_difference('QiRda.count') do
      post :create, :qi_rda => @qi_rda.attributes
    end

    assert_redirected_to qi_rda_path(assigns(:qi_rda))
  end

  test "should show qi_rda" do
    get :show, :id => @qi_rda.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @qi_rda.to_param
    assert_response :success
  end

  test "should update qi_rda" do
    put :update, :id => @qi_rda.to_param, :qi_rda => @qi_rda.attributes
    assert_redirected_to qi_rda_path(assigns(:qi_rda))
  end

  test "should destroy qi_rda" do
    assert_difference('QiRda.count', -1) do
      delete :destroy, :id => @qi_rda.to_param
    end

    assert_redirected_to qi_rdas_path
  end
end
