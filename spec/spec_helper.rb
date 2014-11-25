require 'bundler/setup'
require 'acsv'


# Return possible valid encodings for a test file
#   as returned by a detection method.
def encodings_for_testfile(filename, method=nil)
  encodings = {
    ebcdic:    %w(EBCDIC-UK),
    iso8859_7: %w(ISO-8859-7),
    iso8859:   %w(ISO-8859-1 ISO-8859-2),
    utf8:      %w(utf-8 UTF-8),
    utf16:     %w(UTF-16LE),
    ascii:     %w(ascii)
  }
  if method == 'charlock_holmes' || method == 'uchardet'
    encodings.delete(:iso8859_7)
    encodings[:iso8859] = %w(ISO-8859-1 ISO-8859-2 ISO-8859-7)
    encodings[:ascii]   = %w(ISO-8859-1 ISO-8859-2 UTF-8)
  end

  encodings.select{|s,v| filename.match /_#{s}[._]/}.first.last
end
