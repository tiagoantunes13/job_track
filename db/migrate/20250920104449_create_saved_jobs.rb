class CreateSavedJobs < ActiveRecord::Migration[8.0]
  def change
    create_table :saved_jobs do |t|
      t.references :user, null: false, foreign_key: true
      t.references :job, null: false, foreign_key: true
      t.text :notes
      t.datetime :saved_at, default: -> { 'CURRENT_TIMESTAMP' }
      t.timestamps
    end
  end
end
