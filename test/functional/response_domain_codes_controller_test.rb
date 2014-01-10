require 'test_helper'

class ResponseDomainCodesControllerTest < ActionController::TestCase
  setup do
    @response_domain_code = response_domain_codes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:response_domain_codes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create response_domain_code" do
    assert_difference('ResponseDomainCode.count') do
      post :create, :response_domain_code => @response_domain_code.attributes
    end

    assert_redirected_to response_domain_code_path(assigns(:response_domain_code))
  end

  test "should show response_domain_code" do
    get :show, :id => @response_domain_code.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @response_domain_code.to_param
    assert_response :success
  end

  test "should update response_domain_code" do
    put :update, :id => @response_domain_code.to_param, :response_domain_code => @response_domain_code.attributes
    assert_redirected_to response_domain_code_path(assigns(:response_domain_code))
  end

  test "should destroy response_domain_code" do
    assert_difference('ResponseDomainCode.count', -1) do
      delete :destroy, :id => @response_domain_code.to_param
    end

    assert_redirected_to response_domain_codes_path
  end
end
