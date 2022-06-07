begin
  require 'charlock_holmes'
rescue LoadError
end

module ACSV
  module Detect
    module EncodingHolmes

      DEFAULT_CONFIDENCE = 0.01

      def self.require_name
        'charlock_holmes'
      end

      def self.present?
        defined? ::CharlockHolmes::EncodingDetector
      end

      def self.encoding(data, options)
        if present?
          encdet = ::CharlockHolmes::EncodingDetector.detect(data)
          encdet[:encoding] if encdet[:confidence] > (options[:confidence] || DEFAULT_CONFIDENCE)*100
        end
      end

    end
  end
end
