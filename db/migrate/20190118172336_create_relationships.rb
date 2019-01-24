class CreateRelationships < ActiveRecord::Migration[5.2]
  def up
    create_table :relationships do |t|
      t.integer :entity_id_0
      t.integer :entity_id_1
      t.integer :target_entity_id
      t.string :relationship_type
      t.string :relator
      t.text :description

      t.timestamps
    end
  end

  def down
    drop_table :relationships
  end
end
