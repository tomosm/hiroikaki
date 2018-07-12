# frozen_string_literal: true

# ApplicationJob
class ApplicationJob < ActiveJob::Base
  queue_as :default

  rescue_from(ActiveRecord::RecordNotFound) do |exception|
    logger.info(exception.to_s)
  end
end
