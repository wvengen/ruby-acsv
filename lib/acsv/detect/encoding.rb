require_relative 'encoding_holmes'
require_relative 'encoding_rchardet'
require_relative 'encoding_uchardet'

module ACSV
  module Detect

    ENCODING_DETECTORS = [ EncodingHolmes, EncodingRChardet, EncodingUChardet ]

    # Tries to detect the file encoding.
    #
    # @param file_or_data [File, String] CSV file or data to probe
    # @option options [Number] :confidence minimum confidence level (0-1)
    # @option options [String] :method 
    # @return [String] most probable encoding
    def self.encoding(file_or_data, options={})
      options = {confidence: 0.6}.merge(options)

      if file_or_data.is_a? File
        position = file_or_data.tell
        data = file_or_data.read(4096*8)
        file_or_data.seek(position)
      else
        data = file_or_data
      end

      if options[:method]
        detector = ENCODING_DETECTORS.select{|d| d.require_name == options[:method]}.first
        return detector.encoding(data, options)
      else
        ENCODING_DETECTORS.each do |detector|
          if enc = detector.encoding(data, options)
            return enc
          end
        end
      end
    end

    # @return [Array<Symbol>] List of available methods for
    def self.encoding_methods
      ENCODING_DETECTORS.map(&:require_name)
    end

  end
end
