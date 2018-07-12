# frozen_string_literal: true

# Reference: https://github.com/cerebris/jsonapi-resources/blob/master/lib/jsonapi/configuration.rb
JSONAPI.configure do |config|
  # :underscored_key, :camelized_key, :dasherized_key, or custom
  config.json_key_format = :camelized_key
  # :none, :offset, :paged, or a custom paginator name
  config.default_paginator = :offset
  # config.use_text_errors = true
  # config.exception_class_whitelist = [NotAuthorizedError]
end
