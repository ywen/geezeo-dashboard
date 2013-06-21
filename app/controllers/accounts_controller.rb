class AccountsController < ApplicationController
  def index
    model = Account.fetch
    @presenter = Presenters::Account.new(model)
  end
end
