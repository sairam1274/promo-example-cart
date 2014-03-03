require "rubygems"
require "braintree"

Braintree::Configuration.environment = :sandbox
Braintree::Configuration.merchant_id = "rtf8f6bdz3s67hss"
Braintree::Configuration.public_key = "zgw4j3x6sfznm2t6"
Braintree::Configuration.private_key = "38b3d4477f0a627f93e7d2ca8b489e67"