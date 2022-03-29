if @survey.present?
  json.data do
    json.khata_no @survey.khata_no
  end
else
  json.partial! 'api/v1/shared/errors', detail: "Khata number not found"
end