module SimilarWeb
  module GlobalRank
    # API reference: https://developer.similarweb.com/estimated_visits_api
    # This is for new API
    def global_rank(domain, params = {})
      request_new("#{domain}/global-rank/global-rank", params)
    end
  end
end