class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  # process resize_to_limit: ["480","480"]
  # process resize_to_fit: ["480","480"]
  process resize_to_fill: [480, 480]
  
  # if Rails.env.production?
  #   storage :fog
  # else
  #   storage :file
  # end
  
  storage :file

  # アップロードファイルの保存先ディレクトリは上書き可能
  # 下記はデフォルトの保存先  
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # アップロード可能な拡張子のリスト
  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end