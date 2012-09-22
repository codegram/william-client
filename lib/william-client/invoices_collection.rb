module William
  # Class: This class is used to manage all invoices of a Subscription.
  #
  # Returns an array of Invoice
  class InvoicesCollection < Collection
    include Enumerable

    # Public: Initializes the InvoicesCollections.
    #
    # invoices - array of coupons.
    #
    # Returns nothing.
    def initialize(invoices)
      @collection = invoices.map{|invoice| Invoice.new(invoice) }
    end

    # Public: Lists all invoices that has not been sent to the customer yet.
    #
    # Returns an Array of Invoice.
    def not_sent
      @collection.reject(&:sent?)
    end

    # Public: Lists all invoices that has already been sent to the customer.
    #
    # Returns an Array of Invoice.
    def sent
      @collection.select(&:sent?)
    end
  end
end
