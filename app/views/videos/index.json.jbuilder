json.array!(@videos) do |video|
  json.extract! video, :id, :title, :description, :uri, :good, :bad, :interactionCount
  json.url video_url(video, format: :json)
end
