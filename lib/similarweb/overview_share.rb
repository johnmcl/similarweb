module SimilarWeb
  module OverviewShare
    def overview_share(domain, params = {})
      request_new("#{domain}/traffic-sources/overview-share", params)
    end
  end
end
