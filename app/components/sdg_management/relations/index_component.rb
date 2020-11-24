class SDGManagement::Relations::IndexComponent < ApplicationComponent
  include SDGManagement::Header

  attr_reader :records

  def initialize(records)
    @records = records
  end

  private

    def title
      t("sdg_management.menu.#{model_class.table_name}")
    end

    def model_class
      records.model
    end

    def targets_for(record)
      record.sdg_target_list
    end

    def goals_for(record)
      record.sdg_goals.map(&:code).join(", ")
    end

    def edit_path_for(record)
      send("sdg_management_edit_#{record.class.table_name.singularize}_path", record)
    end
end
