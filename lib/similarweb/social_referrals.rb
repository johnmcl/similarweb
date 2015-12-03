module SimilarWeb
  module SocialReferrals
    def social_referrals(domain)
      response = self.http_client.get "#{domain}/v1/socialreferringsites?Format=JSON&UserKey=#{self.api_key}"
      JSON(response.body)
    end
  end
end
