# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "twotrack/version"

Gem::Specification.new do |spec|
  spec.name          = "twotrack"
  spec.version       = Twotrack::VERSION
  spec.authors       = ["parasquid"]
  spec.email         = ["tristan.gomez@gmail.com"]

  spec.summary       = %q{Implements a functional approach to error handling.}
  spec.description   = %q{As popularized by swlaschin's talk (see https://fsharpforfunandprofit.com/rop/)}
  # spec.homepage      = "TODO: Put your gem's website or public repo URL here."

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rspec-given", "~> 3.8.0"
  spec.add_development_dependency "rspec-mocks", "~> 3.7.0"
  spec.add_development_dependency "byebug"
end
