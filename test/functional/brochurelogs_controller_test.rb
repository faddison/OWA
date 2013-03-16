require 'test_helper'

class BrochurelogsControllerTest < ActionController::TestCase
  setup do
    @brochurelog = brochurelogs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:brochurelogs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create brochurelog" do
    assert_difference('Brochurelog.count') do
      post :create, brochurelog: { brochure_id: @brochurelog.brochure_id, count: @brochurelog.count, date: @brochurelog.date, facility_id: @brochurelog.facility_id }
    end

    assert_redirected_to brochurelog_path(assigns(:brochurelog))
  end

  test "should show brochurelog" do
    get :show, id: @brochurelog
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @brochurelog
    assert_response :success
  end

  test "should update brochurelog" do
    put :update, id: @brochurelog, brochurelog: { brochure_id: @brochurelog.brochure_id, count: @brochurelog.count, date: @brochurelog.date, facility_id: @brochurelog.facility_id }
    assert_redirected_to brochurelog_path(assigns(:brochurelog))
  end

  test "should destroy brochurelog" do
    assert_difference('Brochurelog.count', -1) do
      delete :destroy, id: @brochurelog
    end

    assert_redirected_to brochurelogs_path
  end
end
