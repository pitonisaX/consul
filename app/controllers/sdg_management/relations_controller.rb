class SDGManagement::RelationsController < SDGManagement::BaseController
  def index
    @records = relatable_class.accessible_by(current_ability).page(params[:page]).order(:id)
  end

  private

    def relatable_class
      params[:relatable_type].classify.constantize
    end
end
