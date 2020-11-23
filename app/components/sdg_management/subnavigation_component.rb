class SDGManagement::SubnavigationComponent < ApplicationComponent
  attr_reader :current

  def initialize(current:)
    @current = current
  end

  private

    def sections
      %i[goals targets local_targets]
    end

    def link_to_section(section)
      link_to "SDG::#{section.to_s.classify}".constantize.model_name.human(count: 2).titleize,
              path_for(section),
              "aria-selected": section == current
    end

    def path_for(section)
      {
        controller: "sdg_management/#{section}",
        action: :index
      }
    end
end
