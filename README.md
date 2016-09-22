# doctree-ruby

doctree-ruby is a Ruby gem for generating doctrees f.e. from HTML documents.

## Installation

```
    $ gem install doctree
```

## Usage

Use `html2doctree` from the command line to extract links in list items from HTML pages:

    curl https://en.wikipedia.org/wiki/Book | html2doctree --css "#toc"
    
See [test/doctree_test.rb](test/doctree_test.rb) for examples in Ruby code.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ralfebert/doctree-ruby.

