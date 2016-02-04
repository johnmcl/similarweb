module SimilarWeb
  module Referrals
    def referrals(domain)
      request("#{domain}/v2/leadingreferringsites")
    end
  end
end
