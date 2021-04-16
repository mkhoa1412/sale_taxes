# frozen_string_literal: true

require './product'
class ProductFactory
  EXEMPTION_REGEX = Regexp.union(/book/, /chocolate/, /pills/)
  def self.generate(data, name)
    data.merge!({ exempt: true }) if name.match?(EXEMPTION_REGEX)

    if name.include?('imported')
      ImportedProduct.new(data)
    else
      Product.new(data)
    end
  end
end
