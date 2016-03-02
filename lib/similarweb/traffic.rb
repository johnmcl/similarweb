module SimilarWeb
  module Traffic
    def traffic(domain)
      request("#{domain}/v1/traffic")
    end
  end
end
