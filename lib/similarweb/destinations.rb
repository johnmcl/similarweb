module SimilarWeb
  module Destinations
    def destinations(domain)
      request_old("#{domain}/v2/leadingdestinationsites")
    end
  end
end
