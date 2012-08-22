require "yaml"

module William
  # Accesses william config.
  #
  # @return [Config]
  #   The config object
  #
  # @example
  #   William.config[:app_name]
  #     # => 'Empresaula'
  #
  def self.config
    @config ||= Config.new
  end

  # The config object holds all the runtime configurations needed for spinach
  # to run.
  #
  class Config
    attr_accessor :william_api_url,
                :app_name,
                :app_token

    # The "william_api_url" used to connect with william service.
    #
    # @return [String]
    #    The william api service url.
    #
    def william_api_url
      @william_api_url || ENV['WILLIAM_API_URL']
    end

    # The "app_name" used for digest authentication.
    #
    # @return [String]
    #    The app name.
    #
    def app_name
      @app_name || ENV['WILLIAM_API_APP']
    end

    # The "app_token" used for digest authentication
    #
    # @return [String]
    #    The app token.
    #
    def app_token
      @app_token || ENV['WILLIAM_API_TOKEN']
    end
  end
end
