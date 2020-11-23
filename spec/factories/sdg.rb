FactoryBot.define do
  factory :sdg_goal, class: "SDG::Goal" do
    sequence(:code) { |n| n }
  end

  factory :sdg_target, class: "SDG::Target" do
    sequence(:code, 1) { |n| "#{n}.#{n}" }
  end

  factory :sdg_local_target, class: "SDG::LocalTarget" do
    sequence(:code, 1)        { |n| "#{n}.#{n}.#{n}" }
    sequence(:title, 1)       { |n| "Local Target #{n} title" }
    sequence(:description, 1) { |n| "Help for Local Target #{n}" }
  end
end
