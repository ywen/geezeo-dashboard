class Account < ModelBase
  class << self
    def fetch
      accounts_array = Connector.get :accounts
      accounts_array.map {|h| Account.new(h) }
    end
  end
end
