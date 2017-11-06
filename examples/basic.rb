#!/usr/bin/env ruby

require_relative "../lib/twotrack"

class PrintHello
  def self.call
    puts "hello"
  end
end

class PrintBye
  def self.call
    puts "bye"
    "passed from bye"
  end
end

class PrintPassed
  def self.call(&block)
    puts block.call
  end
end

class CauseError
  def self.call
    Object.new.tap { |o|
      def o.message() "there was an error"; end
      def o.switch?() true; end
    }
  end
end

class Error
  def initialize
    @errors = []
  end

  def call(&error)
    @errors.push error.call.message
  end

  def to_s
    @errors.to_s
  end
end

class Ignored
  def self.call
    puts "this should be ignored"
  end
end

errors = Error.new

result = Twotrack::Railway
  .call(PrintHello)
  .then(->{ puts "i'm a lambda!" })
  .then(PrintBye)
  .then(PrintPassed)
  .then(CauseError, errors)
  .then(Ignored)

puts errors
puts result.value.message
