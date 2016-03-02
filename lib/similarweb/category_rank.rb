module SimilarWeb
  module CategoryRank
    def category_rank(domain)
      request("#{domain}/v2/CategoryRank")
    end
  end
end
