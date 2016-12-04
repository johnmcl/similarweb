module SimilarWeb
  module Referrals
    def referrals(domain)
      request_old("#{domain}/v2/leadingreferringsites")
    end
  end
end
