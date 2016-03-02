module SimilarWeb
  module AlsoVisited
    def also_visited(domain)
      request("#{domain}/v2/alsovisited")
    end
  end
end
