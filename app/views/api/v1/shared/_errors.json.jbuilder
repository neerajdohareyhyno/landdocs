json.errors do
  json.status '404'
  json.title 'Not Found'
  json.detail "#{item} with ID #{id} not found"
end 