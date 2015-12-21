json.array!(@profiles) do |profile|
  json.extract! profile, :id, :name, :birthcity, :birthday, :livingplace
  json.url profile_url(profile, format: :json)
end
