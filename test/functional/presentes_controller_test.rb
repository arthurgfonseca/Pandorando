require 'test_helper'

class PresentesControllerTest < ActionController::TestCase
  setup do
    @presente = presentes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:presentes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create presente" do
    assert_difference('Presente.count') do
      post :create, :presente => @presente.attributes
    end

    assert_redirected_to presente_path(assigns(:presente))
  end

  test "should show presente" do
    get :show, :id => @presente.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @presente.to_param
    assert_response :success
  end

  test "should update presente" do
    put :update, :id => @presente.to_param, :presente => @presente.attributes
    assert_redirected_to presente_path(assigns(:presente))
  end

  test "should destroy presente" do
    assert_difference('Presente.count', -1) do
      delete :destroy, :id => @presente.to_param
    end

    assert_redirected_to presentes_path
  end
end
