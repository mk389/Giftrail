class IconUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  
  if Rails.env.production?
    storage :fog
  else
    storage :file
  end
  
  def store_dir
    "uploads/user/icon/#{model.id}"
  end
  
  version :thumb do
    process resize_to_fill: [50, 50] 
  end
end