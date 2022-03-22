class CreateLandRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :land_records do |t|
      t.integer :survey_id
      t.string :district_name
      t.string :district_telegu_name
      t.string :mandal_name
      t.string :mandal_telegu_name
      t.string :village_name
      t.string :village_telegu_name
      t.string :survey_no
      t.string :pattadar_name
      t.string :father_husband_name
      t.float :total_extent
      t.string :land_status
      t.string :land_type
      t.string :nature_of_land
      t.string :classification_of_land
      t.float :market_value_of_survey_no_inr
      t.string :transaction_status
      t.string :ekyc_status
      t.string :ppb_no
      t.timestamps
    end
  end
end