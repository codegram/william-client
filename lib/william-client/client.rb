module William
  # Used to connect and retrieve data from William.
  class Client

    # Public: Entry point to william API.
    #
    # Returns an Hyperclient::Entrypoint.
    def self.build
      Hyperclient::EntryPoint.new(William.config.william_api_url, William.config.options.dup)
    end
  end
end
