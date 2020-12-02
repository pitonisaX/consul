require "rails_helper"

describe SDGManagement::SubnavigationComponent, type: :component do
  let(:component) do
    SDGManagement::SubnavigationComponent.new(current: :goals) do
      "Tab content"
    end
  end

  it "does not run Foundation component" do
    render_inline component

    expect(page).not_to have_css "[data-tabs]"
  end

  it "renders tabs and links properly styled" do
    render_inline component

    within "li.is-active" do
      expect(page).to have_selector "a[aria-selected=true]", text: "Goals"
    end
    expect(page).to have_selector "a[aria-selected=false]", text: "Targets"
  end

  it "renders given block within active panel" do
    render_inline component

    within "#goals.tabs-panel.is-active" do
      expect(page).to have_content("Tab content")
    end
  end
end
