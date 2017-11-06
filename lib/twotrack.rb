module Twotrack
  class Railway
    def self.call(left, right=nil)
      Left.new(nil).then(left, right)
    end
  end

  class Right
    attr_reader :value
    def initialize(value)
      @value = value
    end

    def switch?
      true
    end

    def then(left, right=nil)
      self # we can never go back to the left track
    end
  end

  class Left
    attr_reader :value
    def initialize(value)
      @value = value
    end

    def then(left, right=nil)
      result = left.call { @value }

      if result.respond_to?(:switch?) && result.switch?
        right.call { result } unless right.nil?
        Right.new(result)
      else
        Left.new(result)
      end
    end
  end
end
