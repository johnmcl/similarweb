module SimilarWeb
  module CategoryRank
    def category_rank(domain)
      response = self.http_client.get "#{domain}/v2/CategoryRank?Format=JSON&UserKey=#{self.api_key}"
      JSON(response.body)
    end
  end
end
