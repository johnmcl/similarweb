module SimilarWeb
  module Category
    def category(domain)
      response = self.http_client.get "#{domain}/v2/category?Format=JSON&UserKey=#{self.api_key}"
      JSON(response.body)
    end
  end
end
