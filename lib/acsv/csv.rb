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
    # In case of reading, the character separator is auto-detected.
    #
    # @option options [String] :internal_encoding encoding to return strings as (default +utf-8+)
    # @see http://www.ruby-doc.org/stdlib/libdoc/csv/rdoc/CSV.html#method-c-new
    def initialize(data, options = Hash.new)
      options[:col_sep] ||= ACSV::Detect.separator(data)
      super(data, options)
    end

    # This method opens an IO object, and wraps that with CSV. For reading, separator
    # and character encoding (when an encoding-detection gem is loaded) are auto-detected.
    #
    # @todo document additional options
    # @todo allow to specify +internal_encoding+ and +external_encoding+?
    # @see http://www.ruby-doc.org/stdlib/libdoc/csv/rdoc/CSV.html#method-c-open
    def self.open(*args)
      # find the +options+ Hash
      options = if args.last.is_a? Hash then args.pop else Hash.new end
      # auto-detect encoding unless external encoding is specified
      mode = args[1] || 'rb'
      mode, ext_enc, int_enc = mode.split(':')
      if ext_enc.nil? || ext_enc == '' || ext_enc == '-'
        # detect encoding
        ext_enc = ACSV::Detect.encoding(File.open(args[0], mode, options), options)
        # workaround for http://stackoverflow.com/a/20723346
        ext_enc = "bom|#{ext_enc}" if ext_enc =~ /UTF/
        # create new mode specification
        mode = "#{mode}:#{ext_enc}"
        mode += ":#{int_enc}" if int_enc
        args[1] = mode
      end
      # to superclass
      args << options
      super(*args)
    end
  end
end
