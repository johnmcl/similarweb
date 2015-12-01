module SimilarWeb
  class Client
    include AlsoVisited
    include EstimatedVisits
    include SimilarSites
    include CategoryRank
    include Destinations
    include Keywords
    include SocialReferrals
    include Category
    include Engagement
    include Referrals
    include Tags
    include Traffic
    attr_accessor :api_key, :http_client

    def initialize(args = {})
      args.each do |key, value|
        send(:"#{key}=", value)
      end
      make_http_client!
    end

    private

      def make_http_client!
        base_url = "http://api.similarweb.com/Site/"
        self.http_client = Faraday.new(:url => base_url)
      end
  end
end
