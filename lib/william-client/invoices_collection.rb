module William
  class InvoicesCollection
    include Enumerable

    def initialize(invoices)
      @invoices = invoices.map{|invoice| Invoice.new(invoice) }
    end

    def not_sent
      @invoices.reject{|invoice| invoice.sent?}
    end

    def sent
      @invoices.select{|invoice| invoice.sent?}
    end

    def each(&block)
      @invoices.each(&block)
    end

    def [](index)
      @invoices[index]
    end
  end
end
