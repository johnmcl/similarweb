module SimilarWeb
  module Destinations
    def destinations(domain)
      request("#{domain}/v2/leadingdestinationsites")
    end
  end
end
