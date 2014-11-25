require 'csv'

module ACSV
  # This class provides a complete interface to CSV files and data while trying
  # to detect the separator and character set. It is Ruby's standard CSV class
  # with auto-detection facilities.
  #
  # Please note that non-rewindable IO objects, like STDIN, are not supported.
  #
  # @see http://www.ruby-doc.org/stdlib/libdoc/csv/rdoc/CSV.html
  class CSV < ::CSV
    # This constructor will wrap either a String or IO object passed in data for reading and/or writing.
    # Detection of encoding happens on IO objects only.
    #
    # By default, text is converted to utf-8. If you want to retain the original encoding, set
    # the +internal_encoding+ option to +nil+
    #
    # @option options [String] :internal_encoding encoding to return strings as (default +utf-8+)
    # @see http://www.ruby-doc.org/stdlib/libdoc/csv/rdoc/CSV.html#method-c-new
    def initialize(data, options = Hash.new)
      if data.is_a? File
        internal_encoding = options.delete(:internal_encoding) { 'utf-8' }
        if internal_encoding
          data.set_encoding("#{ACSV::Detect.encoding(data)}:#{internal_encoding}")
        else
          data.set_encoding("#{ACSV::Detect.encoding(data)}")
        end
      end
      options[:col_sep] ||= ACSV::Detect.separator(data)
      super(data, options)
    end
  end
end
