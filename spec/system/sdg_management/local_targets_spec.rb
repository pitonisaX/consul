require "rails_helper"

describe "Local Targets", :js do
  before do
    login_as(create(:administrator).user)
    Setting["feature.sdg"] = true
  end

  describe "Index" do
    scenario "Visit the index" do
      local_target = create(:sdg_local_target, :find_target, code: "1.1.1", title: "Affordable food")

      visit sdg_management_goals_path
      click_link "Local Targets"

      expect(page).to have_title "SDG content - Local Targets"
      within("table tr", text: "Affordable food") do
        href = edit_sdg_management_local_target_path(local_target)
        expect(page).to have_link "Edit local target", href: href
        expect(page).to have_link "Delete local target", href: sdg_management_local_target_path(local_target)
      end
      expect(page).to have_link "Create local target", href: new_sdg_management_local_target_path
    end

    scenario "Show local targets grouped by target" do
      target_1 = SDG::Target["1.1"]
      target_1_local_target = create(:sdg_local_target, code: "1.1.1", target: target_1)
      target_2 = SDG::Target["2.1"]
      target_2_local_target = create(:sdg_local_target, code: "2.1.1", target: target_2)

      visit sdg_management_local_targets_path

      expect(target_1.title).to appear_before(target_1_local_target.title)
      expect(target_1_local_target.title).to appear_before(target_2.title)
      expect(target_2.title).to appear_before(target_2_local_target.title)
    end
  end

  describe "Create" do
    scenario "Shows succesful notice when form is fullfilled correctly" do
      visit new_sdg_management_local_target_path

      select "1.1", from: "Target"
      fill_in "Code", with: "1.1.1"
      fill_in "Title", with: "Local target title"
      fill_in "Description", with: "Local target description"
      click_button "Create local target"

      expect(page).to have_content("Local target created successfully")
      expect(page).to have_content("1.1.1")
    end

    scenario "Shows form errors when not valid" do
      visit new_sdg_management_local_target_path

      click_button "Create local target"

      expect(page).to have_content("3 errors prevented this SDG/Local Target from being saved.")
    end
  end

  describe "Update" do
    let!(:local_target) { create(:sdg_local_target, :find_target, code: "1.1.1") }

    scenario "Shows succesful notice when form is fullfilled correctly" do
      visit edit_sdg_management_local_target_path(local_target)

      fill_in "Title", with: "Local target title update"
      click_button "Update local target"

      expect(page).to have_content("Local target updated successfully")
      expect(page).to have_content("Local target title update")
    end

    scenario "Shows form errors when not valid" do
      visit edit_sdg_management_local_target_path(local_target)

      fill_in "Title", with: ""
      click_button "Update local target"

      expect(page).to have_content("1 error prevented this SDG/Local Target from being saved.")
    end
  end

  describe "Destroy" do
    scenario "Shows succesful notice when local target is destroyed successfully" do
      create(:sdg_local_target, :find_target, code: "1.1.1")
      visit sdg_management_local_targets_path

      accept_confirm { click_link "Delete local target" }

      expect(page).to have_content("Local target deleted successfully")
      expect(page).not_to have_content("1.1.1")
    end
  end
end
