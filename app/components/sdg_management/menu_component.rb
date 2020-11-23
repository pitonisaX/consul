class SDGManagement::MenuComponent < ApplicationComponent
  private

    def sdg?
      %w[goals targets local_targets].include?(controller_name)
    end

    def relatable_list_item(type, &block)
      active = controller_name == "relations" && params[:relatable_type] == type.tableize

      tag.li class: ("is-active" if active) do
        link_to t("sdg_management.menu.#{table_name(type)}"),
                relatable_type_path(type),
                class: "#{table_name(type).tr("_", "-")}-link"
      end
    end

    def relatable_type_path(type)
      send("sdg_management_#{table_name(type)}_path")
    end

    def table_name(type)
      type.constantize.table_name
    end
end
