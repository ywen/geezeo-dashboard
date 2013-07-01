class Account < ModelBase
  forward_from_hash :name, :id

  class << self
    def fetch
      accounts_array = Connector.get :accounts
      accounts = accounts_array.map {|h| Account.new(h) }
      AccountSaver.save(accounts)
      accounts
    end
  end
end
