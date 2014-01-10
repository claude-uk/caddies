require 'test_helper'

class CcStatementsControllerTest < ActionController::TestCase
  setup do
    @cc_statement = cc_statements(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cc_statements)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cc_statement" do
    assert_difference('CcStatement.count') do
      post :create, :cc_statement => @cc_statement.attributes
    end

    assert_redirected_to cc_statement_path(assigns(:cc_statement))
  end

  test "should show cc_statement" do
    get :show, :id => @cc_statement.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @cc_statement.to_param
    assert_response :success
  end

  test "should update cc_statement" do
    put :update, :id => @cc_statement.to_param, :cc_statement => @cc_statement.attributes
    assert_redirected_to cc_statement_path(assigns(:cc_statement))
  end

  test "should destroy cc_statement" do
    assert_difference('CcStatement.count', -1) do
      delete :destroy, :id => @cc_statement.to_param
    end

    assert_redirected_to cc_statements_path
  end
end
