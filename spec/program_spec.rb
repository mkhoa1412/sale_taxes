# frozen_string_literal: true

require './program'

RSpec.describe Program do
  subject { described_class.new(arguments).run }

  let(:arguments) { ['./input_test', './output_test'] }
  # let(:test_out_file_path) {'./faker/test.txt'}

  it 'print the correct receipt' do
    subject
    expect(CSV.open(Dir.glob('./output_test/*.txt').first).readlines).to eq(
      [['1', ' imported bottle of perfume', ' 32.19'],\
       ['1', ' bottle of perfume', ' 20.89'],\
       ['1', ' packet of headache pills', ' 9.75'],\
       ['1', ' imported box of chocolates', ' 11.85'],\
       ['Sales Taxes: 7.51'],\
       ['Total: 74.68']]
    )
  end
end
