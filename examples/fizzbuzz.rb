#!/usr/bin/env ruby

require_relative "../lib/twotrack"

class Message
  def initialize(value)
    @value = value
  end

  def to_s
    @value
  end

  def switch?
    true
  end
end

class DivisibleBy15
  def self.call(&input)
    number = input.call
    number % 15 == 0 ? Message.new("fizzbuzz") : number
  end
end

class DivisibleBy3
  def self.call(&input)
    number = input.call
    number % 3 == 0 ? Message.new("fizz") : number
  end
end

class DivisibleBy5
  def self.call(&input)
    number = input.call
    number % 5 == 0 ? Message.new("buzz") : number
  end
end

class PrintNumber
  def self.call(&input)
    puts input.call
  end
end

# http://wiki.c2.com/?FizzBuzzTest
# Write a program that prints the numbers from 1 to 100.
# But for multiples of three print “Fizz” instead of the
# number and for the multiples of five print “Buzz”.
# For numbers which are multiples of both three and five
# print “FizzBuzz”.
1.upto(100) do |i|
  # input |> divisible_by_15 |> divisibe_by_3 |> divisible_by_5 |> output
  result = Twotrack::Railway
    .call(->{ i })
    .then(DivisibleBy15, PrintNumber)
    .then(DivisibleBy3, PrintNumber)
    .then(DivisibleBy5, PrintNumber)
    .then(PrintNumber)
end
