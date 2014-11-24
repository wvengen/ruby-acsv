require_relative '../spec_helper'

describe ACSV::Detect do
  describe 'separator' do

    SEPARATORS = {
      :comma => ",",
      :semicolon => ";",
      :tab => "\t",
      :pipe => "|"
    }

    Dir.glob('spec/files/{test,extern}_*') do |file|
      describe "detects" do
        let(:sep) { SEPARATORS.select{|s,v| file.match /_#{s}[._]/}.first.last }

        it "'#{file}' correctly" do
          expect(ACSV::Detect.separator(File.new(file))).to eq sep
        end
      end
    end

  end
end
