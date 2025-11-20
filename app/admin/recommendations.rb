ActiveAdmin.register Recommendation do
  permit_params :user_id, :hearing_aid_id, :notes, :status

  index do
    selectable_column
    column "Patient", :user
    column "Hearing Aid", :hearing_aid
    column :status do |rec|
      status_tag rec.status
    end
    column :created_at
    actions
  end

  form do |f|
    f.inputs "Recommendation" do
      f.input :user, label: "Patient", collection: User.where(role: :patient)
      f.input :hearing_aid
      f.input :status, as: :select, collection: Recommendation.statuses.keys
      f.input :notes
    end
    f.actions
  end
end