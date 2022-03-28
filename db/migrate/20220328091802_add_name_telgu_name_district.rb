class AddNameTelguNameDistrict < ActiveRecord::Migration[7.0]
  def change
    add_column :districts, :telgu_name, :string
  end
end
