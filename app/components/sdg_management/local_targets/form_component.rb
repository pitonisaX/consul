class SDGManagement::LocalTargets::FormComponent < ApplicationComponent
  include SDGManagement::Header
  # TODO: Why delegation of translatable_form_for to helpers is not working?
  include TranslatableFormHelper
  include GlobalizeHelper

  attr_reader :local_target

  def initialize(local_target)
    @local_target = local_target
  end

  private

    def title
      if local_target.persisted?
        t("sdg_management.local_targets.edit.title")
      else
        t("sdg_management.local_targets.new.title")
      end
    end

    def form_url
      if local_target.persisted?
        sdg_management_local_target_path(local_target)
      else
        sdg_management_local_targets_path
      end
    end

    def submit_label
      if local_target.persisted?
        t("sdg_management.local_targets.edit.submit")
      else
        t("sdg_management.local_targets.new.submit")
      end
    end

    def target_options
      options_for_select(SDG::Target.all.sort.map { |target| [target.code, target.id] })
    end
end
