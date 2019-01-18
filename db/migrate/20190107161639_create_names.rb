class CreateNames < ActiveRecord::Migration[5.2]
  def up
    create_table :names do |t|
      t.string :name
      t.string :form

      t.timestamps
    end
    add_reference :names, :entity, foreign_key: true
  end

  def down
    drop_table :names
  end
end
