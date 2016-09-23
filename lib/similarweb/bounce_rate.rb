module SimilarWeb
  module BounceRate
    def bounce_rate(domain, params = {})
      request_new("#{domain}/total-traffic-and-engagement/bounce-rate", params)
    end
  end
end
