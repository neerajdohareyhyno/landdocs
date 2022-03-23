class RemoveKycField < ActiveRecord::Migration[7.0]
  def up
    remove_column :land_records, :ekyc_status
  end

  def down
    add_column :land_records, :ekyc_status, :string
  end
end
