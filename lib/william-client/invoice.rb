module William
  class Invoice
    def initialize(invoice)
    end

    def william_id
      attributes['id']
    end

    def sent_at
      return nil unless attributes['sent_at']
      Date.parse(attributes['sent_at'])
    end

    def ref
      attributes['ref']
    end

    def total
      attributes['total'].to_f
    end

    def link
      resource.links['pdf']
    end

    private
    def resource
      @resource
    end

    def attributes
      resource.attributes
    end
  end
end
