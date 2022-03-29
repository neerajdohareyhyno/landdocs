if @villages.present?
  json.data do
    json.array! @villages, :id, :name, :telgu_name
  end
else
  json.partial! 'api/v1/shared/errors', detail: "Villages not found"
end