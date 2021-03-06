# Textament

Textament is a gem for creating nice console output

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'textament'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install textament

## Usage

Example usage: 

```ruby
data = [
	{name: "haruhi", age: 15, color: "wd描きaw"},
	{name: "kyon", age: 16},
	{name: "mikuru", age: 17, poring: :meow},
	{name: "nagato", age: 15},
	{name: "itsuki", age: 16}
]

Textament.table(data: data, width: 60, theme: Textament::Theme.new, spread: :even)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/davidsiaw/textament. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

