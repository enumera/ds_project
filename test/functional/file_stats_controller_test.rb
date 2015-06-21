require 'test_helper'

class FileStatsControllerTest < ActionController::TestCase
  setup do
    @file_stat = file_stats(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:file_stats)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create file_stat" do
    assert_difference('FileStat.count') do
      post :create, file_stat: { column_size: @file_stat.column_size, creation_date: @file_stat.creation_date, records: @file_stat.records, time_to_load: @file_stat.time_to_load }
    end

    assert_redirected_to file_stat_path(assigns(:file_stat))
  end

  test "should show file_stat" do
    get :show, id: @file_stat
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @file_stat
    assert_response :success
  end

  test "should update file_stat" do
    put :update, id: @file_stat, file_stat: { column_size: @file_stat.column_size, creation_date: @file_stat.creation_date, records: @file_stat.records, time_to_load: @file_stat.time_to_load }
    assert_redirected_to file_stat_path(assigns(:file_stat))
  end

  test "should destroy file_stat" do
    assert_difference('FileStat.count', -1) do
      delete :destroy, id: @file_stat
    end

    assert_redirected_to file_stats_path
  end
end
