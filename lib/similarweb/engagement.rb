module SimilarWeb
  module Engagement
    def engagement(domain)
      request_old("#{domain}/v1/engagement")
    end
  end
end
