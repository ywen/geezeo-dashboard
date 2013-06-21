class AccountsController < ApplicationController
  def index
    model = Models::UserStatistics.fetch
    @presenter = Presenters::UserStatistics.new(model)
  end
end
