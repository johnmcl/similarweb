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
    include Visits
    include PagesPerVisit
    include AverageVisitDuration
    include BounceRate
    include GlobalRank
    include Overview
    include OverviewShare

    attr_reader :http_client_old, :http_client_new

    attr_accessor :api_key

    def initialize(args = {})
      args.each do |key, value|
        send(:"#{key}=", value)
      end
      @http_client_new = Faraday.new(:url => base_url_new)
      @http_client_old = Faraday.new(:url => base_url_old)
    end

    def base_url_new
      @base_url_new ||= "https://api.similarweb.com/v1/website/"
    end

    def base_url_old
      @base_url_old ||= "https://api.similarweb.com/Site/"
    end

    protected

    def request_old(uri, params = {}, http_method = :get)
      url = "#{uri}?Format=JSON&UserKey=#{api_key}&#{to_query(params)}"
      parse_response(http_client_old.public_send(http_method, url))
    end

    def request_new(uri, params = {}, http_method = :get)
      params[:start_date]       ||= Date.today.prev_month
      params[:end_date]         ||= params[:start_date]
      params[:granularity]      ||= 'daily'
      params[:main_domain_only] ||= false

      params[:start_date] = convert_date(params[:start_date])
      params[:end_date]   = convert_date(params[:end_date])

      url = "#{uri}?api_key=#{api_key}&#{to_query(params)}"
      parse_response(http_client_new.public_send(http_method, url))
    end

    def parse_response(response)
      JSON(response.body)
    end

    def to_query(params)
      params.map { |key, value| "#{key}=#{value}" }.join("&")
    end

    def convert_date(date)
      if date.is_a? DateTime or date.is_a? Date or date.is_a? Time
        date.strftime("%Y-%m")
      elsif date.is_a? String
        date
      else
        raise 'invalid date format'
      end
    end
  end
end
