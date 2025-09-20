class CreateExperiences < ActiveRecord::Migration[8.0]
  def change
    create_table :experiences do |t|
      t.string :title
      t.string :company
      t.date :start_date
      t.date :end_date
      t.string :location
      t.text :description
      t.string :notes
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
