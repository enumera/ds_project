require 'test_helper'

class FundRecordsControllerTest < ActionController::TestCase
  setup do
    @fund_record = fund_records(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fund_records)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fund_record" do
    assert_difference('FundRecord.count') do
      post :create, fund_record: { d10: @fund_record.d10, d11: @fund_record.d11, d12: @fund_record.d12, d1: @fund_record.d1, d2: @fund_record.d2, d3: @fund_record.d3, d4: @fund_record.d4, d5: @fund_record.d5, d6: @fund_record.d6, d7: @fund_record.d7, d8: @fund_record.d8, d9: @fund_record.d9, fund: @fund_record.fund, fund_size: @fund_record.fund_size, isin: @fund_record.isin, sector: @fund_record.sector, wd12: @fund_record.wd12, wd26: @fund_record.wd26, wd4: @fund_record.wd4, wr12: @fund_record.wr12, wr26: @fund_record.wr26, wr4: @fund_record.wr4 }
    end

    assert_redirected_to fund_record_path(assigns(:fund_record))
  end

  test "should show fund_record" do
    get :show, id: @fund_record
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fund_record
    assert_response :success
  end

  test "should update fund_record" do
    put :update, id: @fund_record, fund_record: { d10: @fund_record.d10, d11: @fund_record.d11, d12: @fund_record.d12, d1: @fund_record.d1, d2: @fund_record.d2, d3: @fund_record.d3, d4: @fund_record.d4, d5: @fund_record.d5, d6: @fund_record.d6, d7: @fund_record.d7, d8: @fund_record.d8, d9: @fund_record.d9, fund: @fund_record.fund, fund_size: @fund_record.fund_size, isin: @fund_record.isin, sector: @fund_record.sector, wd12: @fund_record.wd12, wd26: @fund_record.wd26, wd4: @fund_record.wd4, wr12: @fund_record.wr12, wr26: @fund_record.wr26, wr4: @fund_record.wr4 }
    assert_redirected_to fund_record_path(assigns(:fund_record))
  end

  test "should destroy fund_record" do
    assert_difference('FundRecord.count', -1) do
      delete :destroy, id: @fund_record
    end

    assert_redirected_to fund_records_path
  end
end
