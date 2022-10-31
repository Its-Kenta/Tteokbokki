require "http/client"
require "json"

abstract struct Joke
    include JSON::Serializable

    use_json_discriminator "type", {single: SingleJoke, twopart: TwoPartJoke}

    getter type : String

    abstract def formatted_joke : String

end

struct SingleJoke < Joke
  getter joke : String

  def formatted_joke : String
    joke
  end
end

struct TwoPartJoke < Joke
  getter setup : String
  getter delivery : String

  def formatted_joke : String
    "#{setup}\n#{delivery}"
  end
end

def get_joke
  HTTP::Client.get "https://v2.jokeapi.dev/joke/Programming" do |resp|
    Joke.from_json resp.body_io
  end
end
