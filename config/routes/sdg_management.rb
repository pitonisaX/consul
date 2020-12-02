namespace :sdg_management do
  root to: "goals#index"

  resources :goals, only: [:index]
  resources :targets, only: [:index]
  resources :local_targets, only: [:index, :new, :create, :edit, :update]
end
