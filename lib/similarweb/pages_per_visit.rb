module SimilarWeb
  module PagesPerVisit
    def pages_per_visit(domain, params = {})
      request_new("#{domain}/total-traffic-and-engagement/pages-per-visit", params)
    end
  end
end
