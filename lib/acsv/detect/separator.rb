module ACSV
  module Detect

    # Possible CSV separators to check
    SEPARATORS = [",", ";", "\t", "|", "#"]

    # @param file_or_data [File, String] CSV file or data to probe
    # @return [String] most probable column separator character from first line, or +nil+ when none found
    # @todo return whichever character returns the same number of columns over multiple lines
    def self.separator(file_or_data)
      if file_or_data.is_a? File
        position = file_or_data.tell
        firstline = file_or_data.readline
        file_or_data.seek(position)
      else
        firstline = file_or_data.split("\n", 2)[0]
      end
      separators = SEPARATORS.map{|s| s.encode(firstline.encoding)}
      sep = separators.map {|x| [firstline.count(x),x]}.sort_by {|x| x[0]}.last
      sep[0] == 0 ? nil : sep[1].encode('ascii')
    end

  end
end
