namespace :sdg_management do
  root to: "goals#index"

  resources :goals, only: [:index]
  resources :targets, only: [:index]
  resources :local_targets, except: [:show]

  get ":relatable_type",
    to: "relations#index",
    constraints: { relatable_type: /#{SDG::Related::RELATABLE_TYPES.map(&:tableize).join("|")}/ }

  SDG::Related::RELATABLE_TYPES.map(&:tableize).each do |type|
    get type,
      to: "relations#index",
      as: type
  end
end
