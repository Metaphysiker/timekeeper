require "test_helper"

class SelectOptionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @select_option = select_options(:one)
  end

  test "should get index" do
    get select_options_url
    assert_response :success
  end

  test "should get new" do
    get new_select_option_url
    assert_response :success
  end

  test "should create select_option" do
    assert_difference('SelectOption.count') do
      post select_options_url, params: { select_option: { name: @select_option.name } }
    end

    assert_redirected_to select_option_url(SelectOption.last)
  end

  test "should show select_option" do
    get select_option_url(@select_option)
    assert_response :success
  end

  test "should get edit" do
    get edit_select_option_url(@select_option)
    assert_response :success
  end

  test "should update select_option" do
    patch select_option_url(@select_option), params: { select_option: { name: @select_option.name } }
    assert_redirected_to select_option_url(@select_option)
  end

  test "should destroy select_option" do
    assert_difference('SelectOption.count', -1) do
      delete select_option_url(@select_option)
    end

    assert_redirected_to select_options_url
  end
end
