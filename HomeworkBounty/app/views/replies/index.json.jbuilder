json.array!(@replies) do |reply|
  json.extract! reply, :id, :body, :count
  json.url reply_url(reply, format: :json)
end
