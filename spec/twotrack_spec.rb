require "spec_helper"

RSpec.describe Twotrack do
  it "has a version number" do
    expect(Twotrack::VERSION).not_to be nil
  end

  describe "operations" do
    Given(:operation) { double("op", call: nil) }
    context "it calls the given operation" do
      When { Twotrack::Railway.call(operation) }
      Then { expect(operation).to have_received(:call) }
    end

    Given(:chained_operation) { double("chained_op", call: nil) }
    context "it calls the chained operation" do
      When {
        Twotrack::Railway
          .call(operation)
          .then(chained_operation)
      }
      Then { expect(chained_operation).to have_received(:call) }
    end

    Given(:passed_value) { double("passed_value_spy", passed: true) }
    Given(:value_passing_operation) { double("value_passing_op", call: passed_value ) }
    Given(:receiving_op) {
      Class.new {
        def self.call(&block)
          block.call.passed
        end
      }
    }
    context "it passes the return value of the previous op to the next operation" do
      When {
        Twotrack::Railway
          .call(operation)
          .then(value_passing_operation)
          .then(receiving_op)
      }
      Then { expect(passed_value).to have_received(:passed) }
    end

    Given(:error_spy) { spy("error_spy") }
    Given(:error_handler) {
      Class.new {
        def initialize(spy)
          @spy = spy
        end

        def call(&block)
          @spy.trigger(block.call.value)
        end
      }.new(error_spy)
    }
    Given(:error) {
      Class.new {
        def self.value
          "divided by zero"
        end

        def self.switch?
          true
        end
      }
    }
    Given(:error_returning_operation) { double("error_returning_op", call: error) }
    context "it calls the 'right' parameter if the left parameter returns a switch" do
      When {
        Twotrack::Railway
          .call(operation)
          .then(error_returning_operation, error_handler)
      }
      Then { expect(error_spy).to have_received(:trigger) }

      context "it passes the object returned by the op into the 'right' parameter" do
        Then { expect(error_spy).to have_received(:trigger).with("divided by zero") }
      end
    end

    Given(:ignored_operation) { spy("ignored_op") }
    context "it skips the rest of the pipeline when switched" do
      When {
        Twotrack::Railway
          .call(operation)
          .then(error_returning_operation)
          .then(ignored_operation)
          .then(ignored_operation)
          .then(ignored_operation)
        }
      Then { expect(ignored_operation).to_not have_received(:call) }
    end
  end
end
