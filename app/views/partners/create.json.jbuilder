json.data do
  json.partner do
    json.call(@partner, :name, :auth_token)
  end
end
