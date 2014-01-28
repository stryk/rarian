class S3object < ActiveRecord::Base
  before_destroy :delete_s3objects
  attr_accessible :storable_id, :storable_type, :checksum, :key, :bucket

  belongs_to :storable, polymorphic: true

  private

  def delete_s3objects
    CleanUpS3objectsWorker.perform_async(self.bucket,self.key)
  end

end
