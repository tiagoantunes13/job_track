class CreateIgnoredJobs < ActiveRecord::Migration[8.0]
  def change
    create_table :ignored_jobs do |t|
      t.string :external_job_id, null: false, index: true
      t.string :source, null: false, default: 'internal'
      t.text :reason
      t.date :ignored_at, default: -> { 'CURRENT_TIMESTAMP' }
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
