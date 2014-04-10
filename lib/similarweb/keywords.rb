module Similarweb
  module Keywords
    def keywords(domain)
      response = self.http_client.get "#{domain}/v1/searchintelligence?Format=JSON&UserKey=#{self.api_key}"
      JSON(response.body)
    end
  end
end