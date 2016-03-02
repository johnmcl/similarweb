module SimilarWeb
  module Keywords
    def keywords(domain)
      request("#{domain}/v1/searchintelligence")
    end
  end
end
