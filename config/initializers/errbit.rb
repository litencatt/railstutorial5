Airbrake.configure do |config|
  config.host        = ENV['ERRBIT_HOST_NAME']
  config.project_id  = ENV['ERRBIT_APP_ID']
  config.project_key = ENV['ERRBIT_APP_APIKEY']

  # Uncomment for Rails apps
  config.environment = Rails.env
  config.ignore_environments = %w(test)
end
