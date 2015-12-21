json.array!(@lovemusics) do |lovemusic|
  json.extract! lovemusic, :id, :loveword
  json.url lovemusic_url(lovemusic, format: :json)
end
