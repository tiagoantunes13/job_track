class CreateJobApplications < ActiveRecord::Migration[8.0]
  def change
    create_table :job_applications do |t|
      t.text :company
      t.text :position
      t.integer :status, default: 0
      t.text :notes
      t.date :application_date
      t.text :job_posting_url
      t.text :contact_person
      t.integer :expectations, default: 0
      t.references :user, null: true, foreign_key: true

      t.timestamps
    end
  end
end
