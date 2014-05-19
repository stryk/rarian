module CarrierWave
  module Uploader
    module SingleStore
      class Base < CarrierWave::Uploader::Base

        before :remove, :check_if_not_exist

        def check_if_not_exist
          puts "sig exists = " + model.signature
          if( model.present?  && model.class.where("signature=?", model.signature).count>0 )
            raise CarrierWave::Uploader::Exceptions::NotRemoveFile, 'Not remove'  
          end
        end


        def store_dir
          same_files = model.class.where("signature=?", sha1)
          if(same_files.present?)
            "data/#{mounted_as}/#{same_files.last.id}"
          else
            "data/#{mounted_as}/#{model.id}"
          end
        end

        

        private
        def md5
          chunk = model.send("#{mounted_as}")
          @md5 ||= Digest::MD5.hexdigest(chunk.read)
        end
        def sha1
          chunk = model.send("#{mounted_as}")
          @sha1 ||= Digest::SHA1.hexdigest(chunk.read)
        end

        

      end
    end

    module Exceptions
      class Base < Exception
      end
      class NotRemoveFile < CarrierWave::Uploader::Exceptions::Base
      end
      class NotProcessing < CarrierWave::Uploader::Exceptions::Base
      end
    end #Exceptions

    module Callbacks
      extend ActiveSupport::Concern

      def with_callbacks(kind, *args)
        begin
          self.class._before_callbacks[kind].each { |c| send c, *args }
          yield
        rescue CarrierWave::Uploader::Exceptions::Base
        end
        self.class._after_callbacks[kind].each { |c| send c, *args }
      end

    end # Callbacks
  end
end
