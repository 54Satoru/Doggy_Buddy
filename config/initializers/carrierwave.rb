require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  config.storage :fog
  config.fog_provider = 'fog/aws'
  config.fog_directory  = '54satoruawss3'
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV['AKIAQF33BSMME7BFTXR6'],
    aws_secret_access_key: ENV['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'],
    region: ENV['ap-northeast-1'],
    path_style: true
  }

end