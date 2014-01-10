require 'test_helper'

class ResponseDomainTextsControllerTest < ActionController::TestCase
  setup do
    @response_domain_text = response_domain_texts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:response_domain_texts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create response_domain_text" do
    assert_difference('ResponseDomainText.count') do
      post :create, :response_domain_text => @response_domain_text.attributes
    end

    assert_redirected_to response_domain_text_path(assigns(:response_domain_text))
  end

  test "should show response_domain_text" do
    get :show, :id => @response_domain_text.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @response_domain_text.to_param
    assert_response :success
  end

  test "should update response_domain_text" do
    put :update, :id => @response_domain_text.to_param, :response_domain_text => @response_domain_text.attributes
    assert_redirected_to response_domain_text_path(assigns(:response_domain_text))
  end

  test "should destroy response_domain_text" do
    assert_difference('ResponseDomainText.count', -1) do
      delete :destroy, :id => @response_domain_text.to_param
    end

    assert_redirected_to response_domain_texts_path
  end
end
