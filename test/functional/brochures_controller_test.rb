require 'test_helper'

class BrochuresControllerTest < ActionController::TestCase
  setup do
    @brochure = brochures(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:brochures)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create brochure" do
    assert_difference('Brochure.count') do
      post :create, brochure: { name: @brochure.name }
    end

    assert_redirected_to brochure_path(assigns(:brochure))
  end

  test "should show brochure" do
    get :show, id: @brochure
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @brochure
    assert_response :success
  end

  test "should update brochure" do
    put :update, id: @brochure, brochure: { name: @brochure.name }
    assert_redirected_to brochure_path(assigns(:brochure))
  end

  test "should destroy brochure" do
    assert_difference('Brochure.count', -1) do
      delete :destroy, id: @brochure
    end

    assert_redirected_to brochures_path
  end
end
