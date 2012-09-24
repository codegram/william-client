module William
  # Represents a single William resource.
  class Resource
    extend Forwardable

    attr_reader :resource
    def_delegators :@resource, :attributes, :links

    # Public: Initializes the resource with the data it represents.
    #
    # resource - Hyperclient::Resource with all resource data.
    #
    # Returns nothing.
    def initialize(resource)
      @resource = resource
    end

    # Public: Current resource id at William service.
    #
    # Returns a String.
    def william_id
      attributes['id']
    end
  end
end
