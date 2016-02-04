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

    attr_reader :http_client

    attr_accessor :api_key

    def initialize(args = {})
      args.each do |key, value|
        send(:"#{key}=", value)
      end
      @http_client = Faraday.new(:url => base_url)
    end

    def base_url
      @base_url ||= "http://api.similarweb.com/Site/"
    end

    protected

    def request(uri, params = {}, http_method = :get)
      parse_response(http_client.public_send(http_method, "#{uri}?Format=JSON&UserKey=#{api_key}"))
    end

    def parse_response(response)
      JSON(response.body)
    end

  end
end
