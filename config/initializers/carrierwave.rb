 unless Rails.env.development? || Rails.env.test?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: 'OHVtGiDYDSnSBpkj78cs/rcphigBz+bIXb1sTm+z',
      region: 'ap-northeast-1'
    }
    config.fog_public = false

    config.fog_directory  = 'agepan-image'
    config.cache_storage = :fog
  end
 end