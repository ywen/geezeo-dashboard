module Presenters
  class Account
    include ModelPresenter::Base
    forward_from_model :response_hash
  end
end
