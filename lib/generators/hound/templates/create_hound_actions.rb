class CreateHoundActions < ActiveRecord::Migration
  def self.up
    create_table :hound_actions do |t|
      t.string   :action,          null: false
      t.string   :actionable_type, null: false
      t.integer  :actionable_id,   null: false
      t.integer  :user_id
      t.datetime :created_at
      t.text     :changeset
    end
    add_index :hound_actions, [:actionable_type, :actionable_id]
  end

  def self.down
    remove_index :hound_actions, [:actionable_type, :actionable_id]
    drop_table :hound_actions
  end
end