module Presenters
  class Transaction
    include ModelPresenter::Base
    forward_from_model :original_name, :memo, :tags
    moneyize :balance

    private

    def balance
      model.debit? ? 0-model.balance : model.balance
    end
  end
end
