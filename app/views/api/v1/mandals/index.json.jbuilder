if @district.present?
  json.data do
    json.id @district.id
    json.name @district.name
    json.telgu_name @district.telgu_name
    json.mandals do
      json.array! @mandals, :id, :name, :telgu_name
    end
  end
elsif @mandals.present?
  json.data do
    json.array! @mandals, :id, :name, :telgu_name
  end
else
  json.partial! 'api/v1/shared/errors', detail: "District with ID #{params[:district_id]} not found"
end