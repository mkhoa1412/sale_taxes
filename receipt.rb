# frozen_string_literal: true

require 'delegate'
require './formatter'
require './product'

class Receipt < DelegateClass(Array)
  def initialize
    super([])
  end

  def total_sale_price
    value = map(&:sale_price).reduce(:+)
    Formatter.new(value).money
  end

  def total_sale_tax
    value = map(&:sale_tax).reduce(:+)
    Formatter.new(value).money
  end

  def print
    result = "#{parse_items}\n"
    result += "Sales Taxes: #{total_sale_tax}\n"
    result += "Total: #{total_sale_price}"
    result
  end

  private

  def parse_items
    map do |item|
      "#{item.quantity}, #{item.name}, #{Formatter.new(item.price).money}"
    end.join("\n")
  end
end
