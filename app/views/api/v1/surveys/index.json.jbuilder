if @village.present?
  json.data do
    json.id @village.id
    json.name @village.name
    json.telgu_name @village.telgu_name
    json.surveys do
      json.array! @surveys, :id, :survey_no
    end
  end
elsif params[:village_id].present? && @village.nil?
  json.partial! 'api/v1/shared/errors', detail: "Village with ID #{params[:village_id]} not found"
else
  json.partial! 'api/v1/shared/errors', detail: "Village ID should be pass"
end