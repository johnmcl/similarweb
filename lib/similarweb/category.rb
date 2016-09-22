module SimilarWeb
  module Category
    def category(domain)
      request_old("#{domain}/v2/category")
    end
  end
end
