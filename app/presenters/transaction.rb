module Presenters
  class Transaction
    include ModelPresenter::Base
    forward_from_model :response_hash
  end
end
