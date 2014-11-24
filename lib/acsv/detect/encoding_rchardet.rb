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

      def self.present?
        defined? ::CharDet
      end

      def self.encoding(data, options)
        if present?
          encdet = ::CharDet.detect(data)
          encdet["encoding"] if encdet["confidence"] > options[:confidence]
        end
      end

    end
  end
end
