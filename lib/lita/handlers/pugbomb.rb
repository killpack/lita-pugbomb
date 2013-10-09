require 'lita'

module Lita
  module Handlers
    class Pugbomb < Handler
      route(/\bpug me\b/i, :pug, command: true, help: { "pug me" => "Display a single pug" })
      route(/\bpug bomb( (\d+))?/i, :bomb, command: true, help: { "pug bomb" => "Display five pugs", "pug bomb N" => "Display N pugs" })
      route(/how many pugs are there/i, :count, command: true, help: { "how many pugs are there" => "Gets the current number of pugs" })

      BASE_URL = "http://pugme.herokuapp.com"

      def pug(response)
        data = MultiJson.load(http.get(BASE_URL + "/pug").body)
        response.reply data['pug']
      end

      def bomb(response)
        count = response.matches[0][1] || 5
        data = MultiJson.load(http.get(BASE_URL + "/bomb", count: count).body)
        data['pugs'].each do |pug|
          response.reply pug
        end
      end

      def count(response)
        data = MultiJson.load(http.get(BASE_URL + "/count").body)
        pug_count = data['pug_count']
        response.reply "There are #{pug_count} pugs."
      end
    end
  end
end
