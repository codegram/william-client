module William
  class Invoice
    def initialize(invoice)
      @resource = invoice
    end

    def william_id
      attributes['id']
    end

    def sent_at
      return nil unless sent?
      Date.parse(attributes['sent_at'])
    end

    def ref
      attributes['ref']
    end

    def total
      attributes['total'].to_f
    end

    def link
      resource.links.links
    end

    def sent?
      return false unless attributes['sent_at'] != ''
      true
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
