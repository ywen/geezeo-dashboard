module Presenters
  class AccountSummary
    include ModelPresenter::Base
    moneyize :balance
    alias_method :accounts, :model

    class << self
      def build(models)
        presenters = models.map {|account| Account.new(account) }
        self.new presenters
      end
    end

    def each_account
      accounts.each do |account|
        yield account
      end
    end

    def balance
      accounts.reduce(0) {|sum, account| sum += account.balance }
    end
  end
end
