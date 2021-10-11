class CreateHandMasters < ActiveRecord::Migration[5.1]
  def change
    create_table :hand_masters do |t|
      t.string 'hand_name', null: false
      t.integer 'strength', null: false
      t.string 'note', null: true
      t.timestamps
    end
  end
end
