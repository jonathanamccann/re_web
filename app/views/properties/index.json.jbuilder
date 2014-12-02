json.array!(@properties) do |property|
  json.extract! property, :id, :organization_id, :title, :description
  json.url property_url(property, format: :json)
end
