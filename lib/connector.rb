require 'yajl'
module Connector
  class << self
    def get(kind)
      Yajl::Parser.parse(class_name(kind).new.fetch.body, symbolize_keys: true)
    end

    #https://{api_key}@beta-geezeosandbox.geezeo.com/api/v1/users/{user_id}/accounts
    #https://{api_key}@beta-geezeosandbox.geezeo.com/api/v1/users/{user_id}/accounts/{account_id}/transactions

    private

    def class_name(kind)
      "Connector::#{kind.to_s.singularize.classify}".constantize
    end
  end

  class Account
  end

  class Transaction
  end

end
