class CreateModels < ActiveRecord::Migration[8.0]
  def change
    create_table :models do |t|
      t.string :model_id, null: false
      t.string :name, null: false
      t.string :provider, null: false
      t.string :family
      t.datetime :model_created_at
      t.integer :context_window
      t.integer :max_output_tokens
      t.date :knowledge_cutoff

      t.jsonb :modalities, default: {}
      t.jsonb :capabilities, default: []
      t.jsonb :pricing, default: {}
      t.jsonb :metadata, default: {}

      t.timestamps

      t.index [:provider, :model_id], unique: true
      t.index :provider
      t.index :family

      t.index :capabilities, using: :gin
      t.index :modalities, using: :gin

    end

    # Load models from JSON
    say_with_time "Loading models from models.json" do
      RubyLLM.models.load_from_json!
      Model.save_to_database
    end
  end
end
