require 'test_helper'

class ReferrallogsControllerTest < ActionController::TestCase
  setup do
    @referrallog = referrallogs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:referrallogs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create referrallog" do
    assert_difference('Referrallog.count') do
      post :create, referrallog: { count: @referrallog.count, date: @referrallog.date, facility_id: @referrallog.facility_id, referral_id: @referrallog.referral_id }
    end

    assert_redirected_to referrallog_path(assigns(:referrallog))
  end

  test "should show referrallog" do
    get :show, id: @referrallog
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @referrallog
    assert_response :success
  end

  test "should update referrallog" do
    put :update, id: @referrallog, referrallog: { count: @referrallog.count, date: @referrallog.date, facility_id: @referrallog.facility_id, referral_id: @referrallog.referral_id }
    assert_redirected_to referrallog_path(assigns(:referrallog))
  end

  test "should destroy referrallog" do
    assert_difference('Referrallog.count', -1) do
      delete :destroy, id: @referrallog
    end

    assert_redirected_to referrallogs_path
  end
end
