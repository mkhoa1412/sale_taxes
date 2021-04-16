# frozen_string_literal: true

require 'bigdecimal'
require './tax'

class Product
  attr_reader :quantity, :price, :name, :taxes

  def initialize(**opts)
    raise ArgumentError if opts[:quantity].nil? || opts[:quantity].to_i < 1
    raise ArgumentError if opts[:price].nil?

    @quantity = opts[:quantity].to_i
    @price = BigDecimal(opts[:price].to_s)
    @name = opts[:name]&.strip
    post_initialize(opts)
  end

  def sale_price
    price * quantity
  end

  def sale_tax
    (sale_price * Tax.rate(taxes)).round(2)
  end

  protected

  # subclasses may override
  def post_initialize(opts)
    @taxes = opts[:exempt] ? [:exemption] : [:basic]
  end
end

class ImportedProduct < Product
  def post_initialize(opts)
    @taxes = begin
      taxes = super || []
      taxes << :imported
    end
  end
end
