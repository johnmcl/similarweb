module SimilarWeb
  module Tags
    def tags(domain)
      request_old("#{domain}/v2/tags")
    end
  end
end
