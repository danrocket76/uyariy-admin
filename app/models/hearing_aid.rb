class HearingAid < ApplicationRecord
  has_many :recommendations

  validates :brand, :model_name, :price, presence: true
  validates :stock, numericality: { greater_than_or_equal_to: 0 }

  def self.ransackable_attributes(auth_object = nil)
    ["brand", "device_model", "price", "stock", "technical_specs", "created_at", "id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["recommendations"]
  end

end