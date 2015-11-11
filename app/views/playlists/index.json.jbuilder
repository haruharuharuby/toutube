json.array!(@playlists) do |playlist|
  json.extract! playlist, :id, :name, :video_id, :user_id
  json.url playlist_url(playlist, format: :json)
end
