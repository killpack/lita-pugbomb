require 'lita'

module Lita
  module Handlers
    class Dogebomb < Handler
      route(/\bdoge me\b/i, :doge, command: true, help: { "doge me" => "Display a single doge" })
      route(/\bdoge ?bomb( (\d+))?/i, :bomb, command: true, help: { "doge bomb" => "Display five doges", "doge bomb N" => "Display N doges" })
      route(/how many doges are there/i, :count, command: true, help: { "how many doges are there" => "Gets the current number of doges" })

      BASE_URL = "http://dogeme.rowanmanning.com"

      def doge(response)
        data = MultiJson.load(http.get(BASE_URL + "/random").body)
        response.reply data['doge']
      end

      def bomb(response)
        count = response.matches[0][1] || 5
        data = MultiJson.load(http.get(BASE_URL + "/bomb", count: count).body)
        data['doges'].each do |doge|
          response.reply doge
        end
      end

      def count(response)
        data = MultiJson.load(http.get(BASE_URL + "/count").body)
        doge_count = data['doge_count']
        response.reply "There are #{doge_count} doges."
      end
    end
    Lita.register_handler(Dogebomb)
  end
end
