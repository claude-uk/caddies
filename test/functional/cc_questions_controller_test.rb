require 'test_helper'

class CcQuestionsControllerTest < ActionController::TestCase
  setup do
    @cc_question = cc_questions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cc_questions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cc_question" do
    assert_difference('CcQuestion.count') do
      post :create, :cc_question => @cc_question.attributes
    end

    assert_redirected_to cc_question_path(assigns(:cc_question))
  end

  test "should show cc_question" do
    get :show, :id => @cc_question.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @cc_question.to_param
    assert_response :success
  end

  test "should update cc_question" do
    put :update, :id => @cc_question.to_param, :cc_question => @cc_question.attributes
    assert_redirected_to cc_question_path(assigns(:cc_question))
  end

  test "should destroy cc_question" do
    assert_difference('CcQuestion.count', -1) do
      delete :destroy, :id => @cc_question.to_param
    end

    assert_redirected_to cc_questions_path
  end
end
