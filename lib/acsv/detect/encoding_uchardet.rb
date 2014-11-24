begin
  require 'uchardet'
rescue LoadError
end

module ACSV
  module Detect
    module EncodingUChardet

      def self.require_name
        'uchardet'
      end

      def self.encoding(data, options)
        if defined? ::ICU::UCharsetDetector
          encdet = ::ICU::UCharsetDetector.detect(data)
          encdet[:encoding] if encdet[:confidence] > options[:confidence]
        end
      end

    end
  end
end
