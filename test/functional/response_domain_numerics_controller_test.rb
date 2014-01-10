require 'test_helper'

class ResponseDomainNumericsControllerTest < ActionController::TestCase
  setup do
    @response_domain_numeric = response_domain_numerics(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:response_domain_numerics)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create response_domain_numeric" do
    assert_difference('ResponseDomainNumeric.count') do
      post :create, :response_domain_numeric => @response_domain_numeric.attributes
    end

    assert_redirected_to response_domain_numeric_path(assigns(:response_domain_numeric))
  end

  test "should show response_domain_numeric" do
    get :show, :id => @response_domain_numeric.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @response_domain_numeric.to_param
    assert_response :success
  end

  test "should update response_domain_numeric" do
    put :update, :id => @response_domain_numeric.to_param, :response_domain_numeric => @response_domain_numeric.attributes
    assert_redirected_to response_domain_numeric_path(assigns(:response_domain_numeric))
  end

  test "should destroy response_domain_numeric" do
    assert_difference('ResponseDomainNumeric.count', -1) do
      delete :destroy, :id => @response_domain_numeric.to_param
    end

    assert_redirected_to response_domain_numerics_path
  end
end
