begin
  require 'charlock_holmes'
rescue LoadError
end

module ACSV
  module Detect
    module EncodingHolmes

      def self.require_name
        'charlock_holmes'
      end

      def self.encoding(data, options)
        if defined? ::CharlockHolmes::EncodingDetector
          encdet = ::CharlockHolmes::EncodingDetector.detect(data)
          encdet[:encoding] if encdet[:confidence] > options[:confidence]
        end
      end

    end
  end
end
