module SimilarWeb
  module Destinations
    def destinations(domain)
      response = self.http_client.get "#{domain}/v2/leadingdestinationsites?Format=JSON&UserKey=#{self.api_key}"
      JSON(response.body)
    end
  end
end
