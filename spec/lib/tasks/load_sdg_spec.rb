require "rails_helper"

describe "rake db:load_sdg" do
  before { Rake::Task["db:load_sdg"].reenable }

  let :run_rake_task do
    Rake.application.invoke_task("db:load_sdg")
  end

  it "populates empty databases and assigns targets correctly" do
    SDG::Goal.destroy_all

    run_rake_task

    expect(SDG::Goal.count).to eq 17
    expect(SDG::Target.count).to eq 169
    expect(SDG::Target["17.1"].goal.code).to eq 17
  end

  it "does not create additional records on populated databases" do
    expect(SDG::Goal.count).to eq 17
    expect(SDG::Target.count).to eq 169

    goal_id = SDG::Goal.last.id
    target_id = SDG::Target.last.id

    run_rake_task

    expect(SDG::Goal.count).to eq 17
    expect(SDG::Target.count).to eq 169
    expect(SDG::Goal.last.id).to eq goal_id
    expect(SDG::Target.last.id).to eq target_id
  end
end
