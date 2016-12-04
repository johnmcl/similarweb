module SimilarWeb
  module AverageVisitDuration
    def average_visit_duration(domain, params = {})
      request_new("#{domain}/total-traffic-and-engagement/average-visit-duration", params)
    end
  end
end
