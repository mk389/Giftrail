class IconUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :file
  
  def store_dir
    "uploads/user/icon/#{model.id}"
  end
  
  version :thumb do
    process resize_to_fill: [50, 50] 
  end
end