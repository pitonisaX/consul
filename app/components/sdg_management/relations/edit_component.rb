class SDGManagement::Relations::EditComponent < ApplicationComponent
  include SDGManagement::Header

  attr_reader :record

  def initialize(record)
    @record = record
  end

  private

    def title
      @record.title
    end

    def update_path
      send("sdg_management_#{record.class.table_name.singularize}_path", record)
    end
end
