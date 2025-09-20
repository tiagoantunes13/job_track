class AddPictureAndLinksToJobs < ActiveRecord::Migration[8.0]
  def change
    add_column :jobs, :picture_url, :string

    create_table :apply_links do |t|
      t.references :job, null: false, foreign_key: true
      t.string :url, null: false
      t.string :source
      t.timestamps
    end
  end
end
