module Presenters
  class Account
    include ModelPresenter::Base
    forward_from_model :balance, :name
  end
end
