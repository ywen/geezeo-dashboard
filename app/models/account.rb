class Account < ModelBase
  forward_from_hash :name, :id

  class << self
    def fetch
      accounts_array = Connector.get :accounts
      accounts = accounts_array.map {|h| Account.new(h) }
      Persistence.save(accounts)
      accounts
    end
  end

  class Persistence
    class << self
      def save(accounts)
        hash_content = {}
        accounts.each do |account|
          hash_content.merge!(account.id => account.name)
        end
        File.open(yaml_file, 'w+') do |file|
          file.write(hash_content.to_yaml)
        end
      end

      def load
        YAML.load_file yaml_file
      end

      private

      def yaml_file
        "#{Rails.root}/tmp/accounts.yml"
      end
    end
  end
end
