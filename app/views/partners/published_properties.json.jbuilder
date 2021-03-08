json.data do
  json.array! @properties do |property|
    json.property do
      json.call(property, :name, :description, :status, :rental_price)
      json.owner do
        json.call(property.owner, :name, :phone)
        json.available? property.owner.available?
      end
    end
  end
end
