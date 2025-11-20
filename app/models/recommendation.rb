class Recommendation < ApplicationRecord
  belongs_to :user
  belongs_to :hearing_aid

  # Status of the recommendation
  enum :status, { pending: 0, approved: 1, rejected: 2, purchased: 3 }

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "notes", "status", "updated_at", "user_id", "hearing_aid_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["hearing_aid", "user"]
  end

end