class AddKhataNo < ActiveRecord::Migration[7.0]
  def change
    add_column :surveys, :khata_no, :integer
  end
end
