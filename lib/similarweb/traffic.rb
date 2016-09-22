module SimilarWeb
  module Traffic
    def traffic(domain)
      request_old("#{domain}/v1/traffic")
    end
  end
end
