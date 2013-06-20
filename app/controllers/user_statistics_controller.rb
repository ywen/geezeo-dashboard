class UserStatisticsController < ApplicationController
  def index
    @presenter = Presenters::UserStatistics.new("s")
  end
end
