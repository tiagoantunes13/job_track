class AddLocationToJobApplications < ActiveRecord::Migration[8.0]
  def change
    add_column :job_applications, :location, :string, default: "Remote", null: false
  end
end
