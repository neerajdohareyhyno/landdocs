if @land_record.present?
  json.data do
    json.id @land_record.id
    json.survey_id @land_record.survey_id
    json.district_name @land_record.district_name
    json.district_telegu_name @land_record.district_telegu_name
    json.mandal_name @land_record.mandal_name
    json.mandal_telegu_name @land_record.mandal_telegu_name
    json.village_name @land_record.village_name
    json.survey_no @land_record.survey_no
    json.pattadar_name @land_record.pattadar_name
    json.father_husband_name @land_record.father_husband_name
    json.total_extent @land_record.total_extent
    json.land_status @land_record.land_status
    json.classification_of_land @land_record.classification_of_land
    json.market_value_of_survey_no_inr @land_record.market_value_of_survey_no_inr
    json.transaction_status @land_record.transaction_status
    json.ppb_no @land_record.ppb_no
  end
else
  json.partial! 'api/v1/shared/errors', detail: "Land record not found"
end
