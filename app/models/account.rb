class Account < ModelBase
  forward_from_hash :name, :id

  class << self
    def fetch
      accounts_array = Connector.get :accounts
      accounts_array.map {|h| Account.new(h) }
    end
  end
end
