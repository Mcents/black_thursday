require 'bigdecimal'
require './test/test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'
require 'csv'


class SalesAnalystTest < MiniTest::Test

  # def test_that_se_is_initialized
  #   se = SalesEngine.from_csv({
  #   :items     => "./test/data/items_fixture.csv",
  #   :merchants => "./test/data/merchants_fixture.csv",
  #   :invoices => "./test/data/invoices_fixture.csv",
  #   :invoice_items => "./test/data/invoice_items_fixture.csv",
  #   :transactions => "./test/data/transactions_fixture.csv",
  #   :customers => "./test/data/customers_fixture.csv"})
  #   sa = SalesAnalyst.new(se)
  #   assert_instance_of SalesAnalyst, sa
  # end
  #
  # def test_it_can_get_average_item
  #   se = SalesEngine.from_csv({
  #   :items     => "./test/data/items_fixture.csv",
  #   :merchants => "./test/data/merchants_fixture.csv",
  #   :invoices => "./test/data/invoices_fixture.csv",
  #   :invoice_items => "./test/data/invoice_items_fixture.csv",
  #   :transactions => "./test/data/transactions_fixture.csv",
  #   :customers => "./test/data/customers_fixture.csv"})
  #   sa = SalesAnalyst.new(se)
  #
  #   assert_equal 1.0, sa.average_items_per_merchant
  # end
  #
  # def test_for_standard_deviation_on_items
  #   se = SalesEngine.from_csv({
  #   :items     => "./data/items.csv",
  #   :merchants => "./data/merchants.csv",
  #   :invoices => "./data/invoices.csv",
  #   :invoice_items => "./data/invoice_items.csv",
  #   :transactions => "./data/transactions.csv",
  #   :customers => "./data/customers.csv"})
  #   sa = SalesAnalyst.new(se)
  #
  #   assert_equal 3.26, sa.average_items_per_merchant_standard_deviation
  #
  # end
  #
  # def test_merchants_with_high_item_count
  #   se = SalesEngine.from_csv({
  #   :items     => "./data/items.csv",
  #   :merchants => "./data/merchants.csv",
  #   :invoices => "./data/invoices.csv",
  #   :invoice_items => "./data/invoice_items.csv",
  #   :transactions => "./data/transactions.csv",
  #   :customers => "./data/customers.csv"})
  #   sa = SalesAnalyst.new(se)
  #
  #   assert_equal 52, sa.merchants_with_high_item_count.length
  # end
  #
  # def test_average_item_price_for_merchant
  #   se = SalesEngine.from_csv({
  #   :items     => "./data/items.csv",
  #   :merchants => "./data/merchants.csv",
  #   :invoices => "./data/invoices.csv",
  #   :invoice_items => "./data/invoice_items.csv",
  #   :transactions => "./data/transactions.csv",
  #   :customers => "./data/customers.csv"})
  #   sa = SalesAnalyst.new(se)
  #
  #   assert_equal 16.66, sa.average_item_price_for_merchant(12334105)
  #   assert_instance_of BigDecimal, sa.average_item_price_for_merchant(12334105)
  # end
  #
  # def test_average_average_price_per_merchant
  #   se = SalesEngine.from_csv({
  #   :items     => "./data/items.csv",
  #   :merchants => "./data/merchants.csv",
  #   :invoices => "./data/invoices.csv",
  #   :invoice_items => "./data/invoice_items.csv",
  #   :transactions => "./data/transactions.csv",
  #   :customers => "./data/customers.csv"})
  #   sa = SalesAnalyst.new(se)
  #
  #   assert_equal 350.29, sa.average_average_price_per_merchant
  # end
  #
  # def test_golden_items
  #   se = SalesEngine.from_csv({
  #   :items     => "./data/items.csv",
  #   :merchants => "./data/merchants.csv",
  #   :invoices => "./data/invoices.csv",
  #   :invoice_items => "./data/invoice_items.csv",
  #   :transactions => "./data/transactions.csv",
  #   :customers => "./data/customers.csv"})
  #   sa = SalesAnalyst.new(se)
  #
  #   assert_equal 5, sa.golden_items.length
  # end
  #
  # def test_it_can_get_average_invoice
  #   se = SalesEngine.from_csv({
  #   :items     => "./test/data/items_fixture.csv",
  #   :merchants => "./test/data/merchants_fixture.csv",
  #   :invoices => "./test/data/invoices_fixture.csv",
  #   :invoice_items => "./test/data/invoice_items_fixture.csv",
  #   :transactions => "./test/data/transactions_fixture.csv",
  #   :customers => "./test/data/customers_fixture.csv"})
  #   sa = SalesAnalyst.new(se)
  #
  #   assert_equal 4.33, sa.average_invoices_per_merchant
  # end
  #
  # def test_it_can_get_average_invoice_standard_deviation
  #   se = SalesEngine.from_csv({
  #   :items     => "./data/items.csv",
  #   :merchants => "./data/merchants.csv",
  #   :invoices => "./data/invoices.csv",
  #   :invoice_items => "./data/invoice_items.csv",
  #   :transactions => "./data/transactions.csv",
  #   :customers => "./data/customers.csv"})
  #   sa = SalesAnalyst.new(se)
  #
  #   assert_equal 3.29, sa.average_invoices_per_merchant_standard_deviation
  # end
  #
  # def test_top_merchants_by_invoice_count
  #   se = SalesEngine.from_csv({
  #   :items     => "./data/items.csv",
  #   :merchants => "./data/merchants.csv",
  #   :invoices => "./data/invoices.csv",
  #   :invoice_items => "./data/invoice_items.csv",
  #   :transactions => "./data/transactions.csv",
  #   :customers => "./data/customers.csv"})
  #   sa = SalesAnalyst.new(se)
  #
  #   assert_equal 12, sa.top_merchants_by_invoice_count.length
  #
  # end
  #
  # def test_bottom_merchants_by_invoice_count
  #   se = SalesEngine.from_csv({
  #   :items     => "./test/data/items_fixture.csv",
  #   :merchants => "./test/data/merchants_fixture.csv",
  #   :invoices => "./test/data/invoices_fixture.csv",
  #   :invoice_items => "./test/data/invoice_items_fixture.csv",
  #   :transactions => "./test/data/transactions_fixture.csv",
  #   :customers => "./test/data/customers_fixture.csv"})
  #   sa = SalesAnalyst.new(se)
  #
  #   assert_equal 3, sa.bottom_merchants_by_invoice_count.length
  #
  # end
  #
  # def test_it_calculates_top_days_by_invoice_count
  #   se = SalesEngine.from_csv({
  #   :items     => "./data/items.csv",
  #   :merchants => "./data/merchants.csv",
  #   :invoices => "./data/invoices.csv",
  #   :invoice_items => "./data/invoice_items.csv",
  #   :transactions => "./data/transactions.csv",
  #   :customers => "./data/customers.csv"})
  #   sa = SalesAnalyst.new(se)
  #   assert_equal [["Wednesday", 741]], sa.top_days_by_invoice_count
  # end
  #
  # def test_it_calculates_percentage_of_invoices_status
  #   se = SalesEngine.from_csv({
  #   :items     => "./data/items.csv",
  #   :merchants => "./data/merchants.csv",
  #   :invoices => "./data/invoices.csv",
  #   :invoice_items => "./data/invoice_items.csv",
  #   :transactions => "./data/transactions.csv",
  #   :customers => "./data/customers.csv"})
  #   sa = SalesAnalyst.new(se)
  #   assert_equal 29.55, sa.invoice_status(:pending)
  #   assert_equal 56.95, sa.invoice_status(:shipped)
  #   assert_equal 13.5, sa.invoice_status(:returned)
  # end
  #
  # def test_it_calculates_total_revenue_by_date
  #   se = SalesEngine.from_csv({
  #   :items     => "./data/items.csv",
  #   :merchants => "./data/merchants.csv",
  #   :invoices => "./data/invoices.csv",
  #   :invoice_items => "./data/invoice_items.csv",
  #   :transactions => "./data/transactions.csv",
  #   :customers => "./data/customers.csv"})
  #   sa = SalesAnalyst.new(se)
  #   date = Time.parse("2009-02-07")
  #   assert_equal 21067.77, sa.total_revenue_by_date(date).to_f
  # end
  #
  # def test_for_top_revenue_earners
  #   se = SalesEngine.from_csv({
  #   :items     => "./test/data/items_fixture.csv",
  #   :merchants => "./test/data/merchants_fixture.csv",
  #   :invoices => "./test/data/invoices_fixture.csv",
  #   :invoice_items => "./test/data/invoice_items_fixture.csv",
  #   :transactions => "./test/data/transactions_fixture.csv",
  #   :customers => "./test/data/customers_fixture.csv"})
  #   sa = SalesAnalyst.new(se)
  #
  #   assert_equal 3, sa.top_revenue_earners(5).length
  #   assert_equal 3, sa.top_revenue_earners.length
  # end

  def test_for_merchants_with_pending_invoices
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv",
    :customers => "./data/customers.csv"})
    sa = SalesAnalyst.new(se)

    assert_equal 467, sa.merchants_with_pending_invoices.length
    assert_instance_of Array, sa.merchants_with_pending_invoices
    assert_instance_of Merchant, sa.merchants_with_pending_invoices[0]
  end

end
