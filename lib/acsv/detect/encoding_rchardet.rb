begin
  require 'rchardet'
rescue LoadError
end

module ACSV
  module Detect
    module EncodingRChardet

      def self.require_name
        'rchardet'
      end

      def self.encoding(data, options)
        if defined? ::CharDet
          encdet = ::CharDet.detect(data)
          encdet["encoding"] if encdet["confidence"] > options[:confidence]
        end
      end

    end
  end
end
