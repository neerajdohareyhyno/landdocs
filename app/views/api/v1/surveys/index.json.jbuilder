if @village.present?
  json.id @village.id
  json.name @village.name
  json.telgu_name @village.telgu_name
  json.data do
    json.array! @surveys, :id, :survey_no
  end 
elsif params[:village_id].present? && @village.nil?
  json.partial! 'api/v1/shared/errors', id: params[:village_id] , item: "Village"
else
  json.errors do
    json.status '404'
    json.title 'Not Found'
    json.detail "Village ID should be pass"
  end 
end