json.array!(@channels) do |channel|
  json.extract! channel, :id, :name, :description, :interactions, :registeres
  json.url channel_url(channel, format: :json)
end
