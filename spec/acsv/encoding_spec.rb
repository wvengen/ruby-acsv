require_relative '../spec_helper'

describe ACSV::Detect do
  describe 'encoding' do

    ENCODINGS = {
      ascii:   %w(ascii ISO-8859-1 ISO-8859-2),
      utf8:    %w(utf-8 UTF-8),
      iso8859: %w(ISO-8859-1 ISO-8859-2)
    }

    ACSV::Detect.encoding_methods.each do |method|
      describe "using #{method}" do

        Dir.glob('spec/files/{test,extern}_*') do |file|
          describe 'detects' do
            let(:enc) { ENCODINGS.select{|s,v| file.match /_#{s}[._]/}.first.last }

            it "'#{file}' correctly" do
              expect(enc).to include ACSV::Detect.encoding(File.new(file), method: method)
            end
          end
        end

      end
    end

    # test a tiny difference between two detection methods, to make sure choosing a method works.
    it 'really knows different methods' do
      file = 'spec/files/test_01_semicolon_ascii.csv'
      expect(ACSV::Detect.encoding(File.new(file), method: 'charlock_holmes')).to eq 'ISO-8859-2'
      expect(ACSV::Detect.encoding(File.new(file), method: 'rchardet')).to eq 'ascii'
    end

  end
end
