require_relative '../spec_helper'

describe ACSV::Detect do
  describe 'encoding' do

    ACSV::Detect.encoding_methods_all.each do |method|
      describe "using #{method}" do

        Dir.glob('spec/files/{test,extern}_*') do |file|
          describe 'detects' do
            let(:enc) { encodings_for_testfile file, method }

            it "'#{file}' correctly" do
              expect(enc).to include ACSV::Detect.encoding(File.new(file), method: method)
            end

            it "does not detect with >1 confidence" do
              expect(ACSV::Detect.encoding(File.new(file), method: method, confidence: 1.1)).to be nil
            end
          end
        end

        it "is included in available methods" do
          expect(ACSV::Detect.encoding_methods).to include method
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
