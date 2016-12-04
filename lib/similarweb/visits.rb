module SimilarWeb
  module Visits
    # API reference: https://developer.similarweb.com/estimated_visits_api
    # This is for new API
    def visits(domain, params = {})
      request_new("#{domain}/total-traffic-and-engagement/visits", params)
    end
  end
end