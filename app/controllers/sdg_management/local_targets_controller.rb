class SDGManagement::LocalTargetsController < SDGManagement::BaseController
  LocalTarget = ::SDG::LocalTarget

  def index
    @local_targets = LocalTarget.all
  end
end
