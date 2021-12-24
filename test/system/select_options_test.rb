require "application_system_test_case"

class SelectOptionsTest < ApplicationSystemTestCase
  setup do
    @select_option = select_options(:one)
  end

  test "visiting the index" do
    visit select_options_url
    assert_selector "h1", text: "Select Options"
  end

  test "creating a Select option" do
    visit select_options_url
    click_on "New Select Option"

    fill_in "Name", with: @select_option.name
    click_on "Create Select option"

    assert_text "Select option was successfully created"
    click_on "Back"
  end

  test "updating a Select option" do
    visit select_options_url
    click_on "Edit", match: :first

    fill_in "Name", with: @select_option.name
    click_on "Update Select option"

    assert_text "Select option was successfully updated"
    click_on "Back"
  end

  test "destroying a Select option" do
    visit select_options_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Select option was successfully destroyed"
  end
end
