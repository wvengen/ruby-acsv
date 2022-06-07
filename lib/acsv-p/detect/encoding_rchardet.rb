begin
  require 'rchardet'
rescue LoadError
end

module ACSV
  module Detect
    module EncodingRChardet

      DEFAULT_CONFIDENCE = 0.2

      def self.require_name
        'rchardet'
      end

      def self.present?
        defined? ::CharDet
      end

      def self.encoding(data, options)
        if present?
          encdet = ::CharDet.detect(data)
          encdet["encoding"] if encdet["confidence"] > (options[:confidence] || DEFAULT_CONFIDENCE)
        end
      end

    end
  end
end
