class CreateVillages < ActiveRecord::Migration[7.0]
  def change
    create_table :villages do |t|
      t.integer :mandal_id
      t.integer :vill_id
      t.string :name
      t.string :telgu_name
      t.timestamps
    end
  end
end
