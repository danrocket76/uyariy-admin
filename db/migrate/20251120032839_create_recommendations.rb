class CreateRecommendations < ActiveRecord::Migration[8.1]
  def change
    create_table :recommendations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :hearing_aid, null: false, foreign_key: true
      t.text :notes
      t.integer :status

      t.timestamps
    end
  end
end
