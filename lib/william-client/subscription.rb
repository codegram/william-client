module William
  class Subscription
    def initialize(resource)
      @resource = resource
    end

    def william_id
      attributes['id']
    end

    def next_billing_date
      Date.parse(attributes['next_billing_date'])
    end

    def periodicity
      attributes['periodicity'].to_sym
    end

    def customer
      customer = resource.embedded.customer.attributes
      Customer.new(customer['cif'], customer['name'], customer['email'])
    end

    def line_items
      attributes['items'].map{|item| Item.new(item['name'], item['unit_price'], item['units'])}
    end

    def coupons
      coupons = @resource.links.coupons.reload.embedded.coupons
      CouponsCollection.new(resource, coupons)
    end

    def invoices
      invoices = @resource.links.invoices.reload.embedded.invoices
      InvoicesCollection.new(invoices)
    end

    private
    def resource
      @resource
    end

    def attributes
      @resource.attributes
    end

    class Customer < Struct.new(:cif, :name, :email)
    end

    class Item < Struct.new(:name, :unit_price, :units)
    end
  end
end
