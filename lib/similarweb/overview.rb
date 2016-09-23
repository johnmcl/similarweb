module SimilarWeb
  module Overview
    def overview(domain, params = {})
      request_new("#{domain}/traffic-sources/overview", params)
    end
  end
end
