module William
  class Resource
    extend Forwardable

    attr_reader :resource
    def_delegator :@resource, :attributes

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

    # Public: Links available for this resource.
    #
    # Returns an Array of links.
    def links
      resource.links
    end
  end
end
