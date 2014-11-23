module ACSV
  module Detect
    module EncodingHolmes

      def self.require_name
        'charlock_holmes'
      end

      def self.encoding(data, options)
        require 'charlock_holmes'
        encdet = ::CharlockHolmes::EncodingDetector.detect(data)
        encdet[:encoding] if encdet[:confidence] > options[:confidence]
      end

    end
  end
end
