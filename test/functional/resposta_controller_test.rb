require 'test_helper'

class RespostaControllerTest < ActionController::TestCase
  setup do
    @respostum = resposta(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:resposta)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create respostum" do
    assert_difference('Respostum.count') do
      post :create, :respostum => @respostum.attributes
    end

    assert_redirected_to respostum_path(assigns(:respostum))
  end

  test "should show respostum" do
    get :show, :id => @respostum.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @respostum.to_param
    assert_response :success
  end

  test "should update respostum" do
    put :update, :id => @respostum.to_param, :respostum => @respostum.attributes
    assert_redirected_to respostum_path(assigns(:respostum))
  end

  test "should destroy respostum" do
    assert_difference('Respostum.count', -1) do
      delete :destroy, :id => @respostum.to_param
    end

    assert_redirected_to resposta_path
  end
end
