module William
  # Used to connect and retrieve data from William.
  class Client

    # Public: Entry point to william API.
    #
    # Returns an Hyperclient::Entrypoint.
    def self.build
      Hyperclient.new(William.config.william_api_url).tap do |api|
        api.digest_auth(William.config.options[:app_name], William.config.options[:app_token])
      end
    end
  end
end
