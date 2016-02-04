module SimilarWeb
  module Category
    def category(domain)
      request("#{domain}/v2/category")
    end
  end
end
