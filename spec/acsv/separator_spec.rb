require_relative '../spec_helper'

describe ACSV::Detect do
  describe 'separator' do

    SEPARATORS = {
      :comma => ",",
      :semicolon => ";",
      :tab => "\t",
      :pipe => "|",
      :hash => "#"
    }

    Dir.glob('spec/files/{test,extern}_*') do |file|
      describe "detects" do
        let(:enc) { encodings_for_testfile(file).first }
        let(:sep) { SEPARATORS.select{|s,v| file.match /_#{s}[._]/}.first.last }

        it "'#{file}' correctly" do
          expect(ACSV::Detect.separator(File.new(file, "rb:#{enc}")).encode('ascii')).to eq sep
        end
      end
    end

  end
end
