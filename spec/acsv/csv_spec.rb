# encoding:utf-8
require_relative '../spec_helper'

describe ACSV::CSV do

  Dir.glob('spec/files/test_01_*') do |file|
    it "reads '#{file}' correctly" do
      data = ACSV::CSV.read(File.new(file))
      expect(data.to_a).to eq [["this"," is a","'test'","file","500"]]
    end
  end

  Dir.glob('spec/files/test_02_*') do |file|
    it "reads '#{file}' correctly" do
      data = ACSV::CSV.read(File.new(file), headers: true)
      expect(data.to_a[1..-1]).to eq [[nil,"1234","éx0tiç","biô","Produßer","eu","1 kg","1.23","6","0","10",nil,nil,"coolstuff"]]
    end
  end

  Dir.glob('spec/files/test_03_*') do |file|
    it "reads '#{file}' correctly" do
      data = ACSV::CSV.read(File.new(file), headers: true)
      expect(data.to_a[1..-1]).to eq [[nil,"1234","sºmething cØʘl & ŵȇɨʕᵭ","biỗ","I.ꟿade.It","eu","1 kg","1.23","6","0","10",nil,nil,"coolstüff"]]
    end
  end

  #it "returns utf-8 by default" do
  #  data = ACSV::CSV.read(File.new('spec/files/'))
  #end

end
