module SimilarWeb
  module SimilarSites
    def similar_sites(domain)
      request("#{domain}/v2/similarsites")
    end
  end
end
