module SimilarWeb
  module CategoryRank
    def category_rank(domain)
      request_old("#{domain}/v2/CategoryRank")
    end
  end
end
