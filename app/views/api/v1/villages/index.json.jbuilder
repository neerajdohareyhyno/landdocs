if @mandal.present?
  json.data do
    json.id @mandal.id
    json.name @mandal.name
    json.telgu_name @mandal.telgu_name
    json.villages do
      json.array! @villages, :id, :name, :telgu_name
    end
  end
elsif @villages.present?
  json.data do
    json.array! @villages, :id, :name, :telgu_name
  end
else
  json.partial! 'api/v1/shared/errors', detail: "Mandal with ID #{params[:mandal_id]} not found"
end