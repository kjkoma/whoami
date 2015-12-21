json.array!(@lovemovies) do |lovemovie|
  json.extract! lovemovie, :id, :loveword
  json.url lovemovie_url(lovemovie, format: :json)
end
