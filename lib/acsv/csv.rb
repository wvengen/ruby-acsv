require 'csv'

module ACSV
  # This class provides a complete interface to CSV files and data while trying
  # to detect the separator and character set. It is Ruby's standard CSV class
  # with auto-detection facilities.
  #
  # Please note that non-rewindable IO objects, like STDIN, are not supported
  # at the moment.
  #
  # @see ::CSV
  class CSV < ::CSV
    # This constructor will wrap an IO object passed in data for reading and/or writing.
    # @option options [String] :internal_encoding encoding to return strings as (default +utf-8+)
    # @see ::CSV#new
    def initialize(data, options = Hash.new)
      options[:col_sep] ||= ACSV::Detect.separator(data)
      internal_encoding = options.delete(:internal_encoding) { 'utf-8' }
      data.set_encoding("#{ACSV::Detect.encoding(data)}:#{internal_encoding}")
      super(data, options)
    end
  end
end
