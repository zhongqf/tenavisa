require 'test_helper'

class ValuesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:values)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create value" do
    assert_difference('Value.count') do
      post :create, :value => { }
    end

    assert_redirected_to value_path(assigns(:value))
  end

  test "should show value" do
    get :show, :id => values(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => values(:one).to_param
    assert_response :success
  end

  test "should update value" do
    put :update, :id => values(:one).to_param, :value => { }
    assert_redirected_to value_path(assigns(:value))
  end

  test "should destroy value" do
    assert_difference('Value.count', -1) do
      delete :destroy, :id => values(:one).to_param
    end

    assert_redirected_to values_path
  end
end
