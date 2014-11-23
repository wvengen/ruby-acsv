module ACSV
  module Detect
    module EncodingUChardet

      def self.require_name
        'uchardet'
      end

      def self.encoding(data, options)
        require 'uchardet'
        encdet = ::ICU::UCharsetDetector.detect(data)
        encdet[:encoding] if encdet[:confidence] > options[:confidence]
      end

    end
  end
end
