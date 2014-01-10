require 'test_helper'

class CcSequencesControllerTest < ActionController::TestCase
  setup do
    @cc_sequence = cc_sequences(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cc_sequences)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cc_sequence" do
    assert_difference('CcSequence.count') do
      post :create, :cc_sequence => @cc_sequence.attributes
    end

    assert_redirected_to cc_sequence_path(assigns(:cc_sequence))
  end

  test "should show cc_sequence" do
    get :show, :id => @cc_sequence.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @cc_sequence.to_param
    assert_response :success
  end

  test "should update cc_sequence" do
    put :update, :id => @cc_sequence.to_param, :cc_sequence => @cc_sequence.attributes
    assert_redirected_to cc_sequence_path(assigns(:cc_sequence))
  end

  test "should destroy cc_sequence" do
    assert_difference('CcSequence.count', -1) do
      delete :destroy, :id => @cc_sequence.to_param
    end

    assert_redirected_to cc_sequences_path
  end
end
