Dir.glob("#{Rails.root}/app/presenters/*.rb").each {|f| require f }

class ApplicationController < ActionController::Base
  protect_from_forgery
end
