namespace :sdg_management do
  root to: "goals#index"

  resources :goals, only: [:index]
  resources :targets, only: [:index]
  resources :local_targets, except: [:show]

  constraints(relatable_type: /#{SDG::Related::RELATABLE_TYPES.map(&:tableize).join("|")}/) do
    get ":relatable_type", to: "relations#index", as: "relations"
    get ":relatable_type/:id/edit", to: "relations#edit", as: "edit_relation"
  end

  SDG::Related::RELATABLE_TYPES.map(&:tableize).each do |type|
    get type,
      to: "relations#index",
      as: type

    get "#{type}/:id/edit",
      to: "relations#edit",
      as: "edit_#{type.singularize}"
  end
end
