require 'yajl'
module Connector
  class << self
    def get(kind, *args)
      class_name(kind).fetch(*args)
    end

    private

    def class_name(kind)
      "Connector::#{kind.to_s.singularize.classify}".constantize
    end
  end

  class Account
    class << self
      def fetch
        Fetcher.fetch[:accounts]
      end
    end
  end

  class Transaction
    attr_reader :response_hash

    class << self
      def fetch(account_id, page)
        json = Fetcher.fetch("/#{account_id}/transactions?page=#{page}")
        self.new json
      end
    end

    def initialize(response_hash)
      @response_hash = response_hash
    end

    def transactions_array
      response_hash[:transactions] || []
    end

    def next_page
      current_page + 1
    end

    def has_next_page?
      current_page < response_hash[:pages][:total_pages].to_i
    end

    private

    def current_page
      response_hash[:pages][:current_page].to_i
    end
  end

  class Fetcher
    class << self
      def fetch(extra="")
        Yajl::Parser.parse(Curl.get("#{base_url}#{extra}").body_str, symbolize_keys: true)
      end

      private

      def base_url
        credentials = YAML.load_file("#{Rails.root}/config/credentials.yml")
        "https://#{credentials['api_key']}@beta-geezeosandbox.geezeo.com/api/v1/users/#{credentials['user_id']}/accounts"
      end
    end
  end

end
