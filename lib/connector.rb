require 'yajl'
module Connector
  class << self
    def get(kind, *args)
      Yajl::Parser.parse(class_name(kind).fetch(*args).body, symbolize_keys: true)
    end

    #https://{api_key}@beta-geezeosandbox.geezeo.com/api/v1/users/{user_id}/accounts
    #https://{api_key}@beta-geezeosandbox.geezeo.com/api/v1/users/{user_id}/accounts/{account_id}/transactions

    private

    def class_name(kind)
      "Connector::#{kind.to_s.singularize.classify}".constantize
    end
  end

  class Account
    class << self
      def fetch
        Fetcher.fetch
      end
    end
  end

  class Transaction
    class << self
      def fetch(account_id)
        Fetcher.fetch("/#{account_id}/transactions")
      end
    end
  end

  class Fetcher
    class << self
      def fetch(extra="")
        HTTParty.get("#{base_url}#{extra}")
      end

      private

      def base_url
        credentials = YAML.load_file("#{Rails.root}/config/credentials.yml")
        "https://#{credentials['api_key']}@beta-geezeosandbox.geezeo.com/api/v1/users/#{credentials['user_id']}/accounts"
      end
    end
  end

end
