module SimilarWeb
  module AlsoVisited
    def also_visited(domain)
      request_old("#{domain}/v2/alsovisited")
    end
  end
end
