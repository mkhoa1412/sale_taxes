# frozen_string_literal: true

require './receipt'
RSpec.describe Receipt do
  before do
    @receipt1 = described_class.new
    @receipt1 << Product.new({ quantity: 1, price: 12.49, exempt: true })
    @receipt1 << Product.new({ quantity: 1, price: 14.99 })
    @receipt1 << Product.new({ quantity: 1, price: 0.85, exempt: true })

    @receipt2 = described_class.new
    @receipt2 << ImportedProduct.new({ quantity: 1, price: 10.50, exempt: true })
    @receipt2 << ImportedProduct.new({ quantity: 1, price: 54.65 })

    @receipt3 = described_class.new
    @receipt3 << ImportedProduct.new({ quantity: 1, price: 32.19 })
    @receipt3 << Product.new({ quantity: 1, price: 20.89 })
    @receipt3 << Product.new({ quantity: 1, price: 9.75, exempt: true })
    @receipt3 << ImportedProduct.new({ quantity: 1, price: 11.85, exempt: true })
  end

  describe 'receipt #1' do
    it '.total_sale_price ' do
      expect(@receipt1.total_sale_price).to eq('28.33')
    end

    it '.total_sale_tax ' do
      expect(@receipt1.total_sale_tax).to eq('1.50')
    end
  end

  describe 'receipt #2' do
    it '.total_sale_price ' do
      expect(@receipt2.total_sale_price).to eq('65.15')
    end

    it '.total_sale_tax' do
      expect(@receipt2.total_sale_tax).to eq('8.73')
    end
  end

  describe 'receipt #3' do
    it '.total_sale_price ' do
      expect(@receipt3.total_sale_price).to eq('74.68')
    end

    it '.total_sale_tax' do
      expect(@receipt3.total_sale_tax).to eq('7.51')
    end
  end
end
