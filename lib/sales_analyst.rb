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
    merchant = sales_engine.merchants.all
    invoices = sales_engine.invoices.all

    average = (invoices.length.to_f)/(merchant.length)
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

  def collected_invoices_hash
      all_invoices = {}
      mr = @sales_engine.merchants.all
      mr.each do |merchant|
        invoice = sales_engine.collected_invoices(merchant.id)
        all_invoices[merchant.id] = invoice.length
      end
      all_invoices
  end

  def average_items_per_merchant_standard_deviation
    values = collected_items_hash.values
    standard_deviation(values)
  end

  def average_invoices_per_merchant_standard_deviation
    values = collected_invoices_hash.values
    standard_deviation(values)
  end

  def standard_deviation(values)
    average = values.reduce(:+)/values.length.to_f
    average_average = values.reduce(0) {|val, num| val += ((num - average)**2) }
    Math.sqrt(average_average / (values.length-1)).round(2)
  end

  def merchants_with_high_item_count
    mr = sales_engine.merchants.all
    v = average_items_per_merchant+average_items_per_merchant_standard_deviation
    mr.find_all do |merchant|
      merchant.items.length >= v
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
      array_1 << average_item_price_for_merchant(merch.id)
    end
    array_2 = (array_1.reduce(:+)/array_1.length)
    array_2.round(2)
  end

  def golden_items
    ir = sales_engine.items.all
    prices = ir.map {|item| item.unit_price}
    dev = (average_average_price_per_merchant)+(standard_deviation(prices) * 2)
    ir.find_all do |item|
      item.unit_price >= dev
    end
  end

  def top_merchants_by_invoice_count
      top_merchants = (average_invoices_per_merchant_standard_deviation * 2) + average_invoices_per_merchant

      sales_engine.merchants.all.find_all do |merchant|
        merchant.invoices.count > top_merchants
      end
    end

  def bottom_merchants_by_invoice_count
    bottom_merchants = average_invoices_per_merchant - (average_invoices_per_merchant_standard_deviation * 2)

    sales_engine.merchants.all.find_all do |merchant|
      merchant.invoices.count < bottom_merchants
    end
  end

  def generate_deviation(mean, items)
    pre_deviation = (items.reduce(0) do |sum, avg_num|
      sum + ((avg_num - mean) ** 2)
    end)/(items.count - 1).to_f
    Math.sqrt(pre_deviation).round(2)
  end

  def collect_invoices_per_day
    sales_engine.invoices.all.reduce(Hash.new(0)) do |days, invoice|
      invoice_day = invoice.created_at.strftime("%A")
      days[invoice_day] += 1
      days
    end
  end

  def top_days_by_invoice_count
    average = (sales_engine.invoices.all.count / 7).to_f
    invoices_per_day = collect_invoices_per_day.values
    day_deviation = generate_deviation(average, invoices_per_day)
    var = collect_invoices_per_day.find_all do |day,count|
      count > (average + day_deviation)
    end
    var = var.map do |day|
    day.join.to_s[0..-4].split
  end.flatten
  end

  def invoice_staus_percentage(array)
    percentage = BigDecimal.new(array.length) / BigDecimal.new(@sales_engine.invoices.all.length)
    percentage = percentage.to_f * 100
    percentage.round(2)
  end

  def invoice_status(status_symbol)
    array_1 = []
    @sales_engine.invoices.all.each do |invoice|
      if invoice.status == status_symbol
        array_1 << invoice
      end
    end
    invoice_staus_percentage(array_1)
  end

  def find_invoices_by_date(date)
    @sales_engine.invoices.find_invoices_by_date(date)
  end

  def invoices_on_date(date)
    date = date.strftime('%D') if date.is_a?(Time)
    sales_engine.invoices.find_all_by_date(date)
  end

  def total_revenue_by_date(date)
    invoices_on_date(date).reduce(0) do |total, invoice|
      if invoice.total.nil?
        total += 0
      else
        total += invoice.total
      end
    end
  end

  def top_revenue_earners(num=20)
    top_earners = Hash.new
    sales_engine.merchants.all.map do |merchant|
      top_earners[merchant] = merchant.revenue_for_merchant
    end
    top_earners.sort_by do |pair|
      pair[1]
    end.to_h.keys.reverse[0..(num-1)]
  end

  def pending_invoices
    sales_engine.invoices.all.find_all { |invoice| !invoice.is_paid_in_full? }
  end

  def merchants_ranked_by_revenue
    top_revenue_earners(sales_engine.merchants.all.count)
  end

  def merchants_with_pending_invoices(pending = pending_invoices)
    merchant_list = pending.map(&:merchant_id).uniq
    merchant_list.map do |merchant_id|
      sales_engine.merchants.find_by_id(merchant_id)
    end
  end

  def merchants_with_only_one_item
    sales_engine.merchants.all.find_all do |merch|
      merch.items.count == 1
    end
  end

  def merchants_with_only_one_item
    sales_engine.merchants.all.find_all do |merch|
      merch.items.count == 1
    end
  end

  def merchants_with_only_one_item_registered_in_month(month_name)
    sales_engine.merchants.all.find_all do |m|
      m.items.count == 1 && m.created_month.downcase == month_name.downcase
    end
  end

  def invoices_grouped_by_merchant
    sales_engine.invoices.all.group_by do |invoice|
      invoice.merchant_id
    end
  end

  def revenue_by_merchant(merchant_id)
    invoices_grouped_by_merchant[merchant_id].inject(0) do |sum, invoice|
      sum + invoice.invoice_count
    end
  end

  def most_sold_item_for_merchant(merchant_id)
    most_sold = Hash.new(0)
    merchant = sales_engine.merchants.find_by_id(merchant_id)

    merchant.successful_invoices?.map do |invoice|
      invoice.invoice_items.map do |invoice_item|
        most_sold[invoice_item.item_id] += invoice_item.quantity
      end
    end
    iterate_most_sold_item(most_sold)
  end

  def iterate_most_sold_item(hash)
    grab = hash.sort_by do |group|
      group[1]
    end
    top = grab[-1]
    items = grab.find_all do |item|
      item[1] == top[1]
    end
    collect_most_sold_items(items)
  end

  def collect_most_sold_items(item_ids)
    item_ids.map do |item|
      sales_engine.items.find_by_id(item[0])
    end.compact
  end

end
