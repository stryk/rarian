# encoding: utf-8

class AttachedFileUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick
  include ::CarrierWave::Backgrounder::Delay

  # Choose what kind of storage to use for this uploader:
  storage :fog

  # storage :fog

  include CarrierWave::MimetypeFu
  # include CarrierWave::Mimetype
  # process :set_content_type
  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "data/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :scale => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png xls doc pdf dot docx dotx xlt xlsx xltx xlsb ppt pot pps pptx potx ppsx sldx accdb accde accdt)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
  def fog_public
    false
  end
  def initialize(*)
    super

    self.fog_credentials = {
      :provider               => 'AWS',              # required
      :aws_access_key_id      => configatron.AWS_ACCESS_KEY_ID,     # required
      :aws_secret_access_key  => configatron.AWS_SECRET_ACCESS_KEY,   # required
      :path_style => true
    }
    self.fog_directory = configatron.AWS_FILE_BUCKET
    self.asset_host = 'https://files.alphapitch.com'
  end

end
