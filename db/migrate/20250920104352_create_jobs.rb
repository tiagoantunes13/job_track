class CreateJobs < ActiveRecord::Migration[8.0]
  def change
    create_table :jobs do |t|
      t.string :external_job_id, index: true
      t.string :source, null: false, default: 'internal'
      t.string :title, null: false
      t.string :company, null: false
      t.string :location
      t.text :description
      t.string :job_posting_url
      t.jsonb :job_data, default: {}
      t.timestamps

      t.index [:external_job_id, :source], unique: true
    end
  end
end