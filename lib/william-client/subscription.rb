module William
  # Class: This class represents a William subscription.
  class Subscription
    # Public: Initializes the Subscription with the resource data it
    # represents.
    #
    # resource - Hyperclient::Resource with all subscription data.
    #
    # Returns nothing.
    def initialize(resource)
      @resource = resource
    end

    # Public: Current subscription id at William service.
    #
    # Returns a String.
    def william_id
      attributes['id']
    end

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
      coupons = links.coupons.reload.embedded.coupons
      CouponsCollection.new(resource, coupons)
    end

    # Public: Lists all invoices generated for this subscription.
    #
    # Returns a InvoicesCollection.
    def invoices
      invoices = @resource.links.invoices.reload.embedded.invoices
      InvoicesCollection.new(invoices)
    end

    # Public: Links available for this subscription.
    #
    # Returns an Array of links.
    def links
      resource.links
    end

    private
    # Internal: Used to return original resource of this subscription.
    #
    # Returns an Hyperclient::Resource.
    def resource
      @resource
    end

    # Internal: Shortcut for subscription attributes.
    #
    # Returns an Array of attributes.
    def attributes
      resource.attributes
    end

    # Class that represents a subscription customer.
    class Customer < Struct.new(:cif, :name, :email)
    end

    # Class that represents a chargeable item for the subscription.
    class Item < Struct.new(:name, :unit_price, :units)
    end
  end
end
