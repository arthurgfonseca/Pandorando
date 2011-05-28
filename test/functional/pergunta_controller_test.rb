require 'test_helper'

class PerguntaControllerTest < ActionController::TestCase
  setup do
    @perguntum = pergunta(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pergunta)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create perguntum" do
    assert_difference('Perguntum.count') do
      post :create, :perguntum => @perguntum.attributes
    end

    assert_redirected_to perguntum_path(assigns(:perguntum))
  end

  test "should show perguntum" do
    get :show, :id => @perguntum.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @perguntum.to_param
    assert_response :success
  end

  test "should update perguntum" do
    put :update, :id => @perguntum.to_param, :perguntum => @perguntum.attributes
    assert_redirected_to perguntum_path(assigns(:perguntum))
  end

  test "should destroy perguntum" do
    assert_difference('Perguntum.count', -1) do
      delete :destroy, :id => @perguntum.to_param
    end

    assert_redirected_to pergunta_path
  end
end
