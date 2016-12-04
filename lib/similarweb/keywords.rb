module SimilarWeb
  module Keywords
    def keywords(domain)
      request_old("#{domain}/v1/searchintelligence")
    end
  end
end
