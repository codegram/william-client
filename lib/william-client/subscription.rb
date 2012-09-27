module William
  # Class: This class represents a William subscription.
  class Subscription < Resource
    # Public: Date in which a new invoice has to be generated.
    #
    # Returns a Date.
    def next_billing_date
      Date.parse(attributes['next_billing_date'])
    end

    # Public: Determines the way next_billing_date would be calculated. Options
    # are :monthly or :annually.
    #
    # Returns a symbol.
    def periodicity
      attributes['periodicity'].to_sym
    end

    # Public: Shows data about subscription customer.
    #
    # Returns a Customer object.
    def customer
      customer = resource.embedded.customer.attributes
      Customer.new(customer['cif'], customer['name'], customer['email'])
    end

    # Public: Gives all items for which the subscription must be charged for.
    #
    # Returns an array of Item.
    def line_items
      attributes['items'].map{|item| Item.new(item['name'], item['unit_price'], item['units'])}
    end

    # Public: Lists all coupons linked to this subscription.
    #
    # Returns a CouponsCollection.
    def coupons
      coupons = links.coupons.embedded.coupons
      CouponsCollection.new(resource, coupons)
    end

    # Public: Lists all invoices generated for this subscription.
    #
    # Returns a InvoicesCollection.
    def invoices
      invoices = @resource.links.invoices.embedded.invoices
      InvoicesCollection.new(invoices)
    end

    private

    # Class that represents a subscription customer.
    class Customer < Struct.new(:cif, :name, :email)
    end

    # Class that represents a chargeable item for the subscription.
    class Item < Struct.new(:name, :unit_price, :units)
    end
  end
end
