if @mandal.present?
  json.id @mandal.id
  json.name @mandal.name
  json.telgu_name @mandal.telgu_name
  json.data do
    json.array! @villages, :id, :name, :telgu_name
  end 
elsif @villages.present?
  json.array! @villages, :id, :name, :telgu_name
else
  json.partial! 'api/v1/shared/errors', id: params[:mandal_id] , item: "Mandal"
end