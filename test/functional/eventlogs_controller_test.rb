require 'test_helper'

class EventlogsControllerTest < ActionController::TestCase
  setup do
    @eventlog = eventlogs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:eventlogs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create eventlog" do
    assert_difference('Eventlog.count') do
      post :create, eventlog: { event_id: @eventlog.event_id, person_id: @eventlog.person_id }
    end

    assert_redirected_to eventlog_path(assigns(:eventlog))
  end

  test "should show eventlog" do
    get :show, id: @eventlog
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @eventlog
    assert_response :success
  end

  test "should update eventlog" do
    put :update, id: @eventlog, eventlog: { event_id: @eventlog.event_id, person_id: @eventlog.person_id }
    assert_redirected_to eventlog_path(assigns(:eventlog))
  end

  test "should destroy eventlog" do
    assert_difference('Eventlog.count', -1) do
      delete :destroy, id: @eventlog
    end

    assert_redirected_to eventlogs_path
  end
end
