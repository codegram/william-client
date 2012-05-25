# William-client

William-client acts as an interface between
[William](http://github.com/codeswamp/william) and your Ruby application. It
will ideally only be a thin 
[HyperClient](http://github.com/codegram/hyper_client) wrapper, but could
evolve to incorporate more of William's business logic.

# Main goals

* High-level
* Clean interface
* No bullshit

# Usage

```Ruby
# Authentication
william = William::Client.new(api_key)

# Get all the subscriptions
william.subscriptions

# Create a new subscription
william.create_subscription({name: 'Blah'})

# List all the invoices for a subscription
william.subscriptions.first.invoices
```

# Idea: Rack callbacks

In order to receive callbacks from william, `william-client` could be mounted
as a rack application:

```Ruby
# in routes.rb
mount William::Client::RackApp, to: '/william'
```

Then, you could subscribe to them:

```Ruby
William::Client.callbacks.on_failed_payment do |invoice, subscription|
  # Shut off the service
end
```