class CreateEntities < ActiveRecord::Migration[5.2]
  def up
    create_table :entities do |t|
      t.string :authorized_name
      t.string :entity_type
      t.string :legal_status
      t.string :record_status
      t.string :cataloging_level
      t.string :cataloging_language
      t.text :bioghist

      t.timestamps
    end
  end

  def down
    drop_table :entities
  end
end
