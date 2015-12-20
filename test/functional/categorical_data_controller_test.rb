require 'test_helper'

class CategoricalDataControllerTest < ActionController::TestCase
  setup do
    @categorical_datum = categorical_data(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:categorical_data)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create categorical_datum" do
    assert_difference('CategoricalDatum.count') do
      post :create, categorical_datum: { continent: @categorical_datum.continent, country: @categorical_datum.country, deciles: @categorical_datum.deciles, fund_name: @categorical_datum.fund_name, next_wd_four: @categorical_datum.next_wd_four, sector: @categorical_datum.sector }
    end

    assert_redirected_to categorical_datum_path(assigns(:categorical_datum))
  end

  test "should show categorical_datum" do
    get :show, id: @categorical_datum
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @categorical_datum
    assert_response :success
  end

  test "should update categorical_datum" do
    put :update, id: @categorical_datum, categorical_datum: { continent: @categorical_datum.continent, country: @categorical_datum.country, deciles: @categorical_datum.deciles, fund_name: @categorical_datum.fund_name, next_wd_four: @categorical_datum.next_wd_four, sector: @categorical_datum.sector }
    assert_redirected_to categorical_datum_path(assigns(:categorical_datum))
  end

  test "should destroy categorical_datum" do
    assert_difference('CategoricalDatum.count', -1) do
      delete :destroy, id: @categorical_datum
    end

    assert_redirected_to categorical_data_path
  end
end
