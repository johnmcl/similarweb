module Similarweb
  module Tags
    def tags(domain)
      response = self.http_client.get "#{domain}/v2/tags?Format=JSON&UserKey=#{self.api_key}"
      JSON(response.body)
    end
  end
end