class ModelBase
  attr_reader :response_hash
  private :response_hash

  def initialize(response_hash)
    @response_hash = response_hash
  end
end
