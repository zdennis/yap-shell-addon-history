# History for yap-shell

The History addon is provides primitive history capabilities:

* Loads history from ~/.yap/history when yap is loaded
* Saves history to ~/.yap/history when yap exits
* Saving is an append-only operation
* ~/.yap/history is in YAML format

## Shell Functions

The history addon provides the `history` shell function that prints the contents of the history.

## Limitations

The history addon currently does not support any kind of advanced history operations.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'yap-shell-addon-history'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install yap-shell-addon-history

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/yap-shell-addon-history.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
