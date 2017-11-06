[![Build Status](https://travis-ci.org/parasquid/twotrack.svg?branch=master)](https://travis-ci.org/parasquid/twotrack)

# Twotrack

Implements the Railway Oriented Programming pattern (https://fsharpforfunandprofit.com/rop/)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'twotrack'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install twotrack

## Usage

Assumptions:
* The "left" and "right" operations need to respond to `call`. That means you can pass an object that has a `call` method, a `Proc` or a `lambda`. Ruby doesn't allow passing two blocks unfortunately, so for now there's no ability to pass blocks.
* The pipeline starts from the "left" track.
* If the previous operation returned an object that responds to `switch?` and if it responds with `true` then the tracks will switch to the "right" operation.
* There is no way to switch from the "right" track to the "left" track.
* The data returned from the previous operation is passed to the next operation's `call` handler through a block.

See `examples/basic.rb` for a quick rundown of various capabilities.

Railway Oriented Error Handling:
* "success"  means that data should be passed on to the next function (aka "left")
* "failure" means to bypass all intermediate functions and go straight to the end (aka "right")

TODO: example from the talk https://fsharpforfunandprofit.com/rop/
* Validate
* CanonicalizeEmail
* UpdateDb
* SendEmail

It doesn't have to be just about "success" and "failure" (although that's the most common use case)

You can for example implement FizzBuzz with a railway design, with the "left" track being the operations you want to pass the input through, and the "right" track the output (in this case, printing Fizz Buzz FizzBuzz or the number)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/twotrack.
