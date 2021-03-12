require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  config.storage :fog
  config.fog_provider = 'fog/aws'
  config.fog_directory  = 'AWS_BUCKET'
  config.asset_host = "https://s3.ap-northeast-1.amazonaws.com/54satoru-buket"
  config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" }
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV['AWS_ACCESS_KEY'],
    aws_secret_access_key: ENV['AWS_SECRET_KEY'],
    region: ENV['AWS_REGION'],
    path_style: true
  }

end
CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/
