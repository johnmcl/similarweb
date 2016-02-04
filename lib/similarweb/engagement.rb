module SimilarWeb
  module Engagement
    def engagement(domain)
      request("#{domain}/v1/engagement")
    end
  end
end
