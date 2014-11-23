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
    def initialize(data, options = Hash.new)
      options[:col_sep] ||= ACSV::Detect.separator(data)
      options[:encoding] ||= ACSV::Detect.encoding(data)
      super(data, options)
    end
  end
end
