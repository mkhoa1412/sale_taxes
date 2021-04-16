# frozen_string_literal: true

class BasicTax
  def self.rate
    0.1
  end
end

class ImportedTax
  def self.rate
    0.05
  end
end

class ExemptionTax
  def self.rate
    0
  end
end

class Tax
  TYPE_OF_TAXS = {
    basic: BasicTax,
    imported: ImportedTax,
    exemption: ExemptionTax
  }.freeze

  def self.rate(taxs)
    taxs.reduce(0) do |total_rate, tax|
      total_rate + TYPE_OF_TAXS[tax.to_sym].rate
    end
  end
end
