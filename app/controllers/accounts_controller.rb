class AccountsController < ApplicationController
  def index
    models = Account.fetch
    @presenter = Presenters::AccountSummary.build models
  end
end
