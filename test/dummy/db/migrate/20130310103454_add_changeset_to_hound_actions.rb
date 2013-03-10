class AddChangesetToHoundActions < ActiveRecord::Migration
  def change
    add_column :hound_actions, :changeset, :text
  end
end
