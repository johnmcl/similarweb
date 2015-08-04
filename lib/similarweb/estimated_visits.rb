module Similarweb
  module EstimatedVisits
    def estimated_visits(domain)
      response = self.http_client.get "#{domain}/v1/visits?Format=JSON&UserKey=#{self.api_key}"
      JSON(response.body)
    end
  end
end