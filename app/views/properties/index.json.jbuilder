json.data do
  json.array! @properties do |property|
    json.partial! 'properties/property', property: property
  end
end
