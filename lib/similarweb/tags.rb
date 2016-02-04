module SimilarWeb
  module Tags
    def tags(domain)
      request("#{domain}/v2/tags")
    end
  end
end
