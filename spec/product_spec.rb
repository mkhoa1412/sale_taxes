# frozen_string_literal: true

require './product'
RSpec.describe Product do
  let(:obj) { described_class.new({ quantity: 1, price: 2.3 }) }
  let(:exempt_obj) { described_class.new({ quantity: 1, price: 2.3, exempt: true }) }

  it '.sale_price ' do
    expect(obj.sale_price).to eq(BigDecimal('2.3'))
  end

  it '.sale_tax of normal product' do
    expect(obj.sale_tax).to eq(BigDecimal('0.23'))
  end

  it '.sale_tax of exempt product' do
    expect(exempt_obj.sale_tax).to eq(BigDecimal('0'))
  end
end

RSpec.describe ImportedProduct do
  let(:product) { described_class.new({ quantity: 1, price: 2.3 }) }

  it '.sale_price' do
    expect(product.sale_price).to eq(BigDecimal('2.3'))
  end

  it '.sale_tax' do
    expect(product.sale_tax).to eq(BigDecimal('0.35'))
  end
end
