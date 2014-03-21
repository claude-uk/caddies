require 'test_helper'

class QgridRdasControllerTest < ActionController::TestCase
  setup do
    @qgrid_rda = qgrid_rdas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:qgrid_rdas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create qgrid_rda" do
    assert_difference('QgridRda.count') do
      post :create, :qgrid_rda => @qgrid_rda.attributes
    end

    assert_redirected_to qgrid_rda_path(assigns(:qgrid_rda))
  end

  test "should show qgrid_rda" do
    get :show, :id => @qgrid_rda.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @qgrid_rda.to_param
    assert_response :success
  end

  test "should update qgrid_rda" do
    put :update, :id => @qgrid_rda.to_param, :qgrid_rda => @qgrid_rda.attributes
    assert_redirected_to qgrid_rda_path(assigns(:qgrid_rda))
  end

  test "should destroy qgrid_rda" do
    assert_difference('QgridRda.count', -1) do
      delete :destroy, :id => @qgrid_rda.to_param
    end

    assert_redirected_to qgrid_rdas_path
  end
end
