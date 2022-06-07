begin
  require 'uchardet'
rescue LoadError
end

module ACSV
  module Detect
    module EncodingUChardet

      DEFAULT_CONFIDENCE = 0.01

      def self.require_name
        'uchardet'
      end

      def self.present?
        defined? ::ICU::UCharsetDetector
      end

      def self.encoding(data, options)
        if present?
          encdet = ::ICU::UCharsetDetector.detect(data)
          encdet[:encoding] if encdet[:confidence] > (options[:confidence] || DEFAULT_CONFIDENCE)*100
        end
      end

    end
  end
end
