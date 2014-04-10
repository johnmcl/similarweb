module Similarweb
  module Traffic
    def traffic(domain)
      response = self.http_client.get "#{domain}/v1/traffic?Format=JSON&UserKey=#{self.api_key}"
      JSON(response.body)
    end
  end
end