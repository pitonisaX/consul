class SDGManagement::LocalTargetsController < SDGManagement::BaseController
  include Translatable

  LocalTarget = ::SDG::LocalTarget

  def index
    @local_targets = LocalTarget.all
  end

  def new
    @local_target = LocalTarget.new
  end

  def create
    @local_target = LocalTarget.new(local_target_params)

    if @local_target.save
      redirect_to sdg_management_local_targets_path, notice: t("sdg_management.local_targets.create.notice")
    else
      render :new
    end
  end

  private

    def local_target_params
      translations_attributes = translation_params(LocalTarget)
      params.require(:sdg_local_target).permit(:code, :target_id, translations_attributes)
    end
end
