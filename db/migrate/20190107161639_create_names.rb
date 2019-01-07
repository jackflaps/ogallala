class CreateNames < ActiveRecord::Migration[5.2]
  def change
    create_table :names do |t|
      t.string :name
      t.string :form

      t.timestamps
    end
    add_reference :names, :entity, foreign_key: true
  end
end
