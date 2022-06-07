Auto-detecting CSV parser
=========================
[![Gem Version](https://badge.fury.io/rb/acsv.svg)](http://badge.fury.io/rb/acsv)
[![Build Status](https://travis-ci.org/wvengen/ruby-acsv.png?branch=master)](https://travis-ci.org/wvengen/ruby-acsv)

A Ruby gem to read CSVs with auto-detection of encoding and column separator.
Just let people provide a CSV and don't require them to think about format
details if it can be figured out automatically (while providing a way to set it
in case auto-detection fails).

Character set detection is done by either
[rchardet](http://rubygems.org/gems/rchardet),
[uchardet](http://rubygems.org/gems/uchardet) or
[charlock_holmes](http://rubygems.org/gems/charlock_holmes).


Installation
------------

Run

```sh
gem install rchardet
gem install acsv-p
```

or, when using Ruby on Rails, put this in your Gemfile

```ruby
gem 'rchardet'
gem 'acsv-p'
```

and run `bundle install`.


Usage
-----

You can use this exactly as the regular [CSV](http://ruby-doc.org/stdlib/libdoc/csv/rdoc/CSV.html)
module. Just make sure to load a character-detection library _before_ you `require 'acsv'`. Then
use `ACSV::CSV` wherever you would have used `CSV`.

For example:
```ruby
require 'rchardet'
require 'acsv-p'

ACSV::CSV.foreach("spec/files/test_02_semicolon_utf16.csv", headers: true) do |row|
  puts row[1] # => '1234'
end
```

When running this with Ruby's standard CSV, you'll see the error "invalid byte sequence in UTF-8".

Other methods like `read` and `open` are also supported. When passing strings,
e.g. with `new` or `parse`, only the separator is auto-detected.


Options
-------

Instead of [rchardet](http://rubygems.org/gems/rchardet), use can also use
[uchardet](http://rubygems.org/gems/uchardet) or
[charlock_holmes](http://rubygems.org/gems/charlock_holmes).
Just load them before loading acsv. When multiple are loaded, the first one that
returns an encoding above the confidence level (see below) is used. You can also
specify which method to use by passing the `method` option to one of the
`ACSV::CSV` methods. Possible values are `uchardet`, `rchardet` or `charlock_holmes`.
Available methods are also available from `ACSV::Detect.encoding_methods`.

Character encoding detection also returns a confidence level (between 0 and 1).
By default, each method has its own confidence level which matches its performance,
but you can override it by passing the `confidence` option.


Lower-level
-----------

This gem also provides some lower-level methods for encoding and separator detection:

```ruby
require 'rchardet'
require 'acsv-p'

data = File.read("spec/files/test_02_semicolon_iso8859.csv")
encoding = ACSV::Detect.encoding(data)
puts encoding # => 'ISO-8859-1'

data.force_encoding(encoding)
separator = ACSV::Detect.separator(data)
puts separator # => ';'
```

Please see the documentation for `ACSV::Detect` for more information.


Copyright
---------
Copyright © 2014 wvengen, released under GPLv3+ (see LICENSE.md for details).
