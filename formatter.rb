# frozen_string_literal: true

class Formatter
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def money
    '%.2f' % value.truncate(2)
  end
end
