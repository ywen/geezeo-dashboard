class AccountsController < ApplicationController
  def index
    models = Account.fetch
    @presenters = models.map{ |m| Presenters::Account.new(m) }
  end
end
