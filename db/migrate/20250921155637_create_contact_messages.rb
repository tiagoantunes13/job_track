class CreateContactMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :contact_messages do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :subject
      t.text :message, null: false
      t.integer :status, default: 0, null: false
      t.timestamps
    end
  end
end
