class CreateSurveys < ActiveRecord::Migration[7.0]
  def change
    create_table :surveys do |t|
      t.integer :village_id
      t.string :survey_no
      t.timestamps
    end
  end
end
