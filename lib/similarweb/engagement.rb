module SimilarWeb
  module Engagement
    def engagement(domain)
      response = self.http_client.get "#{domain}/v1/engagement?Format=JSON&UserKey=#{self.api_key}"
      JSON(response.body)
    end
  end
end
