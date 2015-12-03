module SimilarWeb
  module SimilarSites
    def similar_sites(domain)
      response = self.http_client.get "#{domain}/v2/similarsites?Format=JSON&UserKey=#{self.api_key}"
      JSON(response.body)
    end
  end
end
