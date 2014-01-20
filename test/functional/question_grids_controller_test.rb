require 'test_helper'

class QuestionGridsControllerTest < ActionController::TestCase
  setup do
    @question_grid = question_grids(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:question_grids)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create question_grid" do
    assert_difference('QuestionGrid.count') do
      post :create, :question_grid => @question_grid.attributes
    end

    assert_redirected_to question_grid_path(assigns(:question_grid))
  end

  test "should show question_grid" do
    get :show, :id => @question_grid.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @question_grid.to_param
    assert_response :success
  end

  test "should update question_grid" do
    put :update, :id => @question_grid.to_param, :question_grid => @question_grid.attributes
    assert_redirected_to question_grid_path(assigns(:question_grid))
  end

  test "should destroy question_grid" do
    assert_difference('QuestionGrid.count', -1) do
      delete :destroy, :id => @question_grid.to_param
    end

    assert_redirected_to question_grids_path
  end
end
