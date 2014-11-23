# encoding:utf-8
require_relative '../spec_helper'

describe ACSV::CSV do

  Dir.glob('spec/files/test_01_*') do |file|
    it "reads '#{file}' correctly" do
      data = ACSV::CSV.read(File.new(file))
      expect(data).to eq [["this"," is a","'test'","file","500"]]
    end
  end

  Dir.glob('spec/files/test_02_*') do |file|
    it "reads '#{file}' correctly" do
      data = ACSV::CSV.read(File.new(file), headers: true)
      expect(data).to eq [["1234","éxòtiç","biô","Produßer","eu","1 kg","1.23","6","0","10","","","","coolstuff"]]
    end
  end

end
