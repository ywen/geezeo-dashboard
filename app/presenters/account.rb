module Presenters
  class Account
    include ModelPresenter::Base
    forward_from_model :balance, :name, :id
    moneyize :balance
  end
end
