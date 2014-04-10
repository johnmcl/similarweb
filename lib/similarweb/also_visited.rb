module Similarweb
  module AlsoVisited
    def also_visited(domain)
      response = self.http_client.get "#{domain}/v2/alsovisited?Format=JSON&UserKey=#{self.api_key}"
      JSON(response.body)
    end
  end
end