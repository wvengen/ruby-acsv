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
    # In case of reading, the character separator is auto-detected (unless given as an option).
    #
    # @see http://www.ruby-doc.org/stdlib/libdoc/csv/rdoc/CSV.html#method-c-new
    def initialize(data, options = Hash.new)
      options[:col_sep] ||= ACSV::Detect.separator(data)
      super(data, **options)
    end

    # This method opens an IO object, and wraps that with CSV. For reading, separator
    # and character encoding (when an encoding-detection gem is loaded) are auto-detected.
    #
    # If the +encoding+ or +external_encoding+ option is set (and not +nil+), or if the
    # external encoding is specified as part of the mode parameter or option, no
    # auto-detection takes place (since the given encoding is used).
    #
    # When auto-detection fails, the default encoding as used by CSV and IO is taken.
    #
    # @option args [Number] :confidence minimum confidence level (0-1)
    # @option args [String] :method try only specific method, one of {ACSV::Detect.encoding_methods}
    # @see ACSV::Detect.encoding
    # @see http://www.ruby-doc.org/stdlib/libdoc/csv/rdoc/CSV.html#method-c-open
    def self.open(*args)
      # find the +options+ Hash
      options = if args.last.is_a? Hash then args.pop else Hash.new end
      # auto-detect encoding unless external encoding is specified
      full_mode = args[1] || 'rb'
      mode, ext_enc, int_enc = full_mode.split(':')
      if (ext_enc.nil? || ext_enc=='') && options[:encoding].nil? && options[:external_encoding].nil?
        # try to detect encoding
        if ext_enc = ACSV::Detect.encoding(File.open(args[0], mode, options), options)
          # workaround for http://stackoverflow.com/a/20723346
          ext_enc = "BOM|#{ext_enc}" if ext_enc =~ /UTF/
          # create new mode specification if there was one, else store in option
          #   only one may be supplied to IO#new so we need to check this
          #   also, BOM may only be specified as part of a mode parameter
          if full_mode.include?(':') || ext_enc.include?('BOM|')
            mode = "#{mode}:#{ext_enc}"
            mode += ":#{int_enc}" if int_enc
            args[1] = mode
          else
            options[:external_encoding] = ext_enc
          end
        end
      end
      # remove options CSV doesn't understand
      options.delete :confidence
      options.delete :method
      # to superclass
      args << options
      super(*args)
    end
  end
end
