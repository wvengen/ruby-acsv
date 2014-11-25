# encoding:utf-8
require_relative '../spec_helper'

describe ACSV::CSV do

  Dir.glob('spec/files/test_01_*') do |file|
    it "reads '#{file}' correctly" do
      data = ACSV::CSV.read(file, 'r::UTF-8')
      expect(data.to_a).to eq [["this"," is a","'test'","file","500"]]
    end
  end

  Dir.glob('spec/files/test_02_*') do |file|
    it "reads '#{file}' correctly" do
      data = ACSV::CSV.read(file, 'r::UTF-8', headers: true)
      expect(data.to_a[1..-1]).to eq [[nil,"1234","éx0tiç","biô","Produßer","eu","1 kg","1.23","6","0","10",nil,nil,"coolstuff"]]
    end
  end

  Dir.glob('spec/files/test_03_*') do |file|
    it "reads '#{file}' correctly" do
      data = ACSV::CSV.read(file, 'r::UTF-8', headers: true)
      expect(data.to_a[1..-1]).to eq [[nil,"1234","sºmething cØʘl & ŵȇɨʕᵭ","biỗ","I.ꟿade.It","eu","1 kg","1.23","6","0","10",nil,nil,"coolstüff"]]
    end
  end

  it "returns specific encoding when asked for" do
    data = ACSV::CSV.read('spec/files/test_01_comma_ascii.csv', 'r::ISO-8859-15')
    expect(data.first.map{|e| e.encoding.to_s}.compact.uniq).to eq ['ISO-8859-15']
  end

  it "returns file encoding by default" do
    data = ACSV::CSV.read('spec/files/test_02_semicolon_utf16.csv')
    expect(data.first.map{|e| e.encoding.to_s}.compact.uniq).to eq ['UTF-16LE']
  end

end
