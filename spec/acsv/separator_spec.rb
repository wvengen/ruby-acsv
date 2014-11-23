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
      it "detects '#{file}' correctly" do
        sep = SEPARATORS.select{|s,v| file.match /_#{s}[._]/}.first.last
        expect(ACSV::Detect.separator(File.new(file))).to eq sep
      end
    end

  end
end
