ActiveAdmin.register HearingAid do
  permit_params :brand, :device_model, :price, :technical_specs, :stock

  index do
    selectable_column
    column :brand
    column :device_model
    column :price do |product|
      number_to_currency product.price
    end
    column :stock
    actions
  end

  filter :brand
  filter :price

  form do |f|
    f.inputs "Hearing Aid Details" do
      f.input :brand
      f.input :device_model
      f.input :price
      f.input :stock
      f.input :technical_specs, as: :text
    end
    f.actions
  end
end