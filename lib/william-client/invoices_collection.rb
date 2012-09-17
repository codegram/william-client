module William
  class InvoicesCollection
    include Enumerable

    def initialize(invoices)
      @invoices = invoices.map{|invoice| Invoice.new(invoice) }
    end

    def each(&block)
      @invoices.each(&block)
    end
  end
end
