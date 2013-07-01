module Presenters
  class Transaction
    include ModelPresenter::Base
    forward_from_model :original_name, :memo, :account_name
    moneyize :balance

    def created_at_str
      model.created_at.to_time.strftime("%m/%d/%Y %I:%M %p")
    end

    def tags
      model.tags.map do |tag|
        tag[:tag][:name]
      end.join(", ")
    end

    private

    def balance
      model.debit? ? 0-model.balance : model.balance
    end
  end
end
