# frozen_string_literal: true

require 'csv'
require './receipt'
require './product_factory'

class Program
  attr_accessor :in_file_path, :out_file_path

  def initialize(args)
    @in_file_path = args[0] || './input'
    @out_file_path = args[1] || './output'
  end

  def run
    puts 'Runing....'

    Dir.entries(in_file_path).each_with_index do |input_name, index|
      next if ['.', '..'].include?(input_name)

      receipt = Receipt.new

      CSV.foreach("#{in_file_path}/#{input_name}", headers: true, header_converters: :symbol) do |row|
        attributes = row.to_h
        attributes[:name] = attributes.delete(:product)
        item = ProductFactory.generate(attributes, attributes[:name])
        receipt << item
      end

      File.open("#{out_file_path}/receipt#{index - 1}.txt", 'w+') do |file|
        file.write(receipt.print)
      end
    end

    puts 'Done. Checkout output folder.'
  end
end

Program.new(ARGV).run if $PROGRAM_NAME == __FILE__
