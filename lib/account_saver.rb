class AccountSaver
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

    private

    def yaml_file
      "#{Rails.root}/tmp/accounts.yml"
    end
  end
end
