class CreateHearingAids < ActiveRecord::Migration[8.1]
  def change
    create_table :hearing_aids do |t|
      t.string :brand
      t.string :device_model
      t.decimal :price, precision: 10, scale: 2
      t.text :technical_specs
      t.integer :stock

      t.timestamps
    end
  end
end
