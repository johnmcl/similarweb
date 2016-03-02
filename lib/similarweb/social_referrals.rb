module SimilarWeb
  module SocialReferrals
    def social_referrals(domain)
      request("#{domain}/v1/socialreferringsites")
    end
  end
end
