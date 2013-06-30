class ModelBase
  attr_reader :response_hash

  class << self
    def forward_from_hash(*keys)
      keys.each do |key|
        define_method key do
          response_hash[key]
        end
      end
    end
  end

  def initialize(response_hash)
    @response_hash = response_hash
  end

  def balance
    response_hash[:balance].to_f * 100
  end

end
