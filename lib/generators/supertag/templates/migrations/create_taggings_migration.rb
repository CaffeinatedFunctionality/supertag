# This migration comes from simple_usertag
class CreateSupertagTaggings < ActiveRecord::Migration
  def change
    create_table :supertag_taggings do |t|
      t.references :tag,      :index => true
      t.references :taggable, :polymorphic => true
    end
    add_index :supertag_taggings, ["taggable_id", "taggable_type"],
              :name => 'index_taggings_taggable_id_taggable_type'
  end
end
