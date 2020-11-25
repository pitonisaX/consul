class SDGManagement::RelationsController < SDGManagement::BaseController
  before_action :load_record, only: [:edit, :update]

  def index
    @records = relatable_class.accessible_by(current_ability).page(params[:page]).order(:id)
  end

  def edit
  end

  def update
    @record.sdg_target_list = params[params[:relatable_type].singularize][:sdg_target_list]

    redirect_to send("sdg_management_#{params[:relatable_type]}_path")
  end

  private

    def load_record
      @record = relatable_class.find(params[:id])
    end

    def relatable_class
      params[:relatable_type].classify.constantize
    end
end
