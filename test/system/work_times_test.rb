require "application_system_test_case"

class WorkTimesTest < ApplicationSystemTestCase
  setup do
    @work_time = work_times(:one)
  end

  test "visiting the index" do
    visit work_times_url
    assert_selector "h1", text: "Work Times"
  end

  test "creating a Work time" do
    visit work_times_url
    click_on "New Work Time"

    fill_in "Minutes", with: @work_time.minutes
    fill_in "Task", with: @work_time.task
    click_on "Create Work time"

    assert_text "Work time was successfully created"
    click_on "Back"
  end

  test "updating a Work time" do
    visit work_times_url
    click_on "Edit", match: :first

    fill_in "Minutes", with: @work_time.minutes
    fill_in "Task", with: @work_time.task
    click_on "Update Work time"

    assert_text "Work time was successfully updated"
    click_on "Back"
  end

  test "destroying a Work time" do
    visit work_times_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Work time was successfully destroyed"
  end
end
