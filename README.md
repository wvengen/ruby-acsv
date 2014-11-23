Auto-detecting CSV parser
=========================
[![Build Status](https://travis-ci.org/wvengen/ruby-acsv.png?branch=master)](https://travis-ci.org/wvengen/ruby-acsv)

A Ruby gem to read CSVs with auto-detection of encoding and column separator.
Just let people upload that CSV and don't require them to bother about format
details if the system can figure it out.

Character set detection is done by either
[charlock_holmes](http://rubygems.org/gems/charlock_holmes),
[rchardet](http://rubygems.org/gems/rchardet) or
[uchardet](http://rubygems.org/gems/uchardet).

WORK IN PROGRESS

