class Admin::SDG::Managers::IndexComponent < ApplicationComponent
  include Admin::Header

  attr_reader :users

  def initialize(users)
    @users = users
  end

  private

    def title
      SDG::Manager.model_name.human(count: 2)
    end
end
