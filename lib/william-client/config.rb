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
    attr_accessor :william_api_url

    # The "william_api_url" used to connect with william service.
    #
    # @return [String]
    #    The william api service url.
    #
    def william_api_url
      @william_api_url || ENV['WILLIAM_API_URL']
    end

    # The connection options to initialize the entry point to William API.
    #
    # @return [Hash]
    #   [:auth] - Authentication type and access data.
    #   [:headers] - Content type.
    #   [:debug] - Enable debug mode [true/false]
    def options
      options = {}
      options[:auth]    = {type: :digest, user: app_name, password: app_token}
      options[:headers] = {'Content-Type' => 'application/json'}
      options[:debug]   = false
      options[:app_name] = app_name
      options[:app_token] = app_token
      options
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
