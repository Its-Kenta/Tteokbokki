require "discordcr"
require "http/client"
require "json"
require "../src/commands/joke"

# Make sure to replace this fake data with actual data when running.
client = Discord::Client.new(token: "TOKEN HERE", client_id: CLIENTID_HERE_u64)
cache = Discord::Cache.new(client)
client.cache = cache

client.on_message_create do |payload|
  if payload.content.starts_with? "!ping"
    client.create_message(payload.channel_id, "Pong!")
  end
end

client.on_message_create do |payload|
  
  if payload.content.starts_with? "!joke"
    client.create_message(payload.channel_id, get_joke.formatted_joke)
  end
end

client.run
