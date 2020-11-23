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

    trait :find_target do
      after :build do |local_target|
        if local_target.code.present?
          code = local_target.code.rpartition(".").first
          local_target.target = SDG::Target[code]
        end
      end
    end
  end
end
