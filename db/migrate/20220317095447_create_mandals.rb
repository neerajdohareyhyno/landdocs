class CreateMandals < ActiveRecord::Migration[7.0]
  def change
    create_table :mandals do |t|
      t.integer :district_id
      t.integer :mand_id
      t.string :name
      t.string :telgu_name
      t.timestamps
    end
  end
end
