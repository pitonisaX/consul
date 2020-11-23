class SDG::LocalTarget < ApplicationRecord
  delegate :goal, to: :target

  translates :title, touch: true
  translates :description, touch: true
  include Globalizable

  validates_translation :title, presence: true
  validates_translation :description, presence: true

  validates :code, presence: true, uniqueness: true
  validates :target, presence: true

  validate :target_exists

  belongs_to :target

  private

    def target_exists
      return if code.blank?

      SDG::Target[code.rpartition(".").first]
    rescue ActiveRecord::RecordNotFound
      errors.add(:code, :target_exists)
    end
end
