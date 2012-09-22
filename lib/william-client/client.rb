module William
  class Client
    include Hyperclient

    # Public: Initializes the client with the necessary connection to the
    # service.
    #
    # Returns nothing.
    def initialize
      self.class.entry_point{ William.config.william_api_url }
      self.class.http_options(headers: {"Content-Type" => "application/json"}, debug: true)
      self.class.auth{ {type: :digest, user: William.config.app_name, password: William.config.app_token} }
    end
  end
end
