require 'test_helper'

class CodeSchemesControllerTest < ActionController::TestCase
  setup do
    @code_scheme = code_schemes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:code_schemes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create code_scheme" do
    assert_difference('CodeScheme.count') do
      post :create, :code_scheme => @code_scheme.attributes
    end

    assert_redirected_to code_scheme_path(assigns(:code_scheme))
  end

  test "should show code_scheme" do
    get :show, :id => @code_scheme.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @code_scheme.to_param
    assert_response :success
  end

  test "should update code_scheme" do
    put :update, :id => @code_scheme.to_param, :code_scheme => @code_scheme.attributes
    assert_redirected_to code_scheme_path(assigns(:code_scheme))
  end

  test "should destroy code_scheme" do
    assert_difference('CodeScheme.count', -1) do
      delete :destroy, :id => @code_scheme.to_param
    end

    assert_redirected_to code_schemes_path
  end
end
