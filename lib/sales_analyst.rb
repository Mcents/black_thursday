require 'pry'
require_relative 'sales_engine'
require 'bigdecimal'

class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    merchant = sales_engine.merchants.all
    items = sales_engine.items.all

    average = (items.length.to_f)/(merchant.length)
    average.round(2)
  end

  def average_invoices_per_merchant
    var = collected_invoices_array
    average = (var.reduce(0) { |sum, num| sum += num})/var.length
    average.round(2)
  end

  def collected_items_hash
      all_merchants = {}
      mr = @sales_engine.merchants.all
      mr.each do |merchant|
        item = sales_engine.collected_items(merchant.id)
        all_merchants[merchant.id] = item.length
      end
      all_merchants
  end

  def collected_invoices_array
      all_invoices = []
      merchant_array = @sales_engine.merchants.all
      merchant_array.each do |merchant|
        invoice = merchant.invoices
        all_invoices << invoice.length
      end
      all_invoices
  end

  def average_items_per_merchant_standard_deviation
    values = collected_items_hash.values
    standard_deviation(values)
  end

  def standard_deviation(values)
    average = values.reduce(:+)/values.length.to_f
    average_average = values.reduce(0) {|val, num| val += ((num - average)**2) }
    Math.sqrt(average_average / (values.length-1)).round(2)
  end

  def merchants_with_high_item_count
    mr = sales_engine.merchants.all
    var = average_items_per_merchant + average_items_per_merchant_standard_deviation
    mr.find_all do |merchant|
      merchant.items.length >= var
    end
  end

  def average_item_price_for_merchant(merchant_id)
    items = sales_engine.collected_items(merchant_id)
    sum = 0
    items.each do |item|
      sum += item.unit_price
    end
    average = sum/(items.length)
    average.round(2)
  end

  def average_average_price_per_merchant
    array_1 = []
    sales_engine.merchants.all.each do |merch|
      id = merch.id
      array_1 << average_item_price_for_merchant(id)
    end
    array_2 = (array_1.reduce(:+)/array_1.length)
    array_2.round(2)
  end

  def golden_items
    ir = sales_engine.items.all
    prices = ir.map {|item| item.unit_price}
    dev = (average_average_price_per_merchant) + (standard_deviation(prices) * 2)
    ir.find_all do |item|
      item.unit_price >= dev
    end
  end

end
