require 'test_helper'

class CountryRelevantsControllerTest < ActionController::TestCase
  setup do
    @country_relevant = country_relevants(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:country_relevants)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create country_relevant" do
    assert_difference('CountryRelevant.count') do
      post :create, country_relevant: { name: @country_relevant.name }
    end

    assert_redirected_to country_relevant_path(assigns(:country_relevant))
  end

  test "should show country_relevant" do
    get :show, id: @country_relevant
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @country_relevant
    assert_response :success
  end

  test "should update country_relevant" do
    put :update, id: @country_relevant, country_relevant: { name: @country_relevant.name }
    assert_redirected_to country_relevant_path(assigns(:country_relevant))
  end

  test "should destroy country_relevant" do
    assert_difference('CountryRelevant.count', -1) do
      delete :destroy, id: @country_relevant
    end

    assert_redirected_to country_relevants_path
  end
end
