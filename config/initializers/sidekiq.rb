# frozen_string_literal: true

config_template = ERB.new File.read Rails.root.join('config', 'cable.yml')
sidekiq_config = YAML.safe_load(config_template.result)[Rails.env]
Sidekiq.configure_server do |config|
  config.redis = { url: sidekiq_config['url'] } if sidekiq_config['url'].present?
end

Sidekiq.configure_client do |config|
  config.redis = { url: sidekiq_config['url'] } if sidekiq_config['url'].present?
end
