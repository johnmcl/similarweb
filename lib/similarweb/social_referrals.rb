module SimilarWeb
  module SocialReferrals
    def social_referrals(domain)
      request_old("#{domain}/v1/socialreferringsites")
    end
  end
end
