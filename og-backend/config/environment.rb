# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# register RDF mime type
Mime::Type.register("application/ld+json", :rdf)
