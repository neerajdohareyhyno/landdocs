if @district.present?
  json.id @district.id
  json.name @district.name
  json.telgu_name @district.telgu_name
  json.data do
    json.array! @mandals, :id, :name, :telgu_name
  end 
elsif @mandals.present?
  json.array! @mandals, :id, :name, :telgu_name
else
  json.partial! 'api/v1/shared/errors', id: params[:district_id] , item: "District"
end