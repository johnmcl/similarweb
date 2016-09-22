module SimilarWeb
  module SimilarSites
    def similar_sites(domain)
      request_old("#{domain}/v2/similarsites")
    end
  end
end
