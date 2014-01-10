require 'test_helper'

class ResponseUnitsControllerTest < ActionController::TestCase
  setup do
    @response_unit = response_units(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:response_units)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create response_unit" do
    assert_difference('ResponseUnit.count') do
      post :create, :response_unit => @response_unit.attributes
    end

    assert_redirected_to response_unit_path(assigns(:response_unit))
  end

  test "should show response_unit" do
    get :show, :id => @response_unit.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @response_unit.to_param
    assert_response :success
  end

  test "should update response_unit" do
    put :update, :id => @response_unit.to_param, :response_unit => @response_unit.attributes
    assert_redirected_to response_unit_path(assigns(:response_unit))
  end

  test "should destroy response_unit" do
    assert_difference('ResponseUnit.count', -1) do
      delete :destroy, :id => @response_unit.to_param
    end

    assert_redirected_to response_units_path
  end
end
