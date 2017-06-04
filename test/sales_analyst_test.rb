require 'bigdecimal'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'


class SalesAnalystTest < MiniTest::Test

  def test_that_se_is_initialized
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    })
    sa = SalesAnalyst.new(se)
    assert_instance_of SalesAnalyst, sa
  end

  def test_it_can_get_average_item
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    })
    sa = SalesAnalyst.new(se)

    assert_equal 2.88, sa.average_items_per_merchant
  end

  def test_for_standard_deviation_on_items
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    })
    sa = SalesAnalyst.new(se)

    assert_equal 3.26, sa.average_items_per_merchant_standard_deviation

  end

  def test_merchants_with_high_item_count
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    })
    sa = SalesAnalyst.new(se)

    assert_equal 52, sa.merchants_with_high_item_count.length
  end

  def test_average_item_price_for_merchant
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    })
    sa = SalesAnalyst.new(se)

    assert_equal 16.66, sa.average_item_price_for_merchant(12334105)
    assert_instance_of BigDecimal, sa.average_item_price_for_merchant(12334105)
  end

  def test_average_average_price_per_merchant
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    })
    sa = SalesAnalyst.new(se)

    assert_equal 350.29, sa.average_average_price_per_merchant
  end

  def test_golden_items
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    })
    sa = SalesAnalyst.new(se)

    assert_equal 5, sa.golden_items.length
  end

  def test_it_can_get_average_invoice
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    })
    sa = SalesAnalyst.new(se)

    assert_equal 10.49, sa.average_invoices_per_merchant
  end

  def test_it_can_get_average_invoice_standard_deviation
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    })
    sa = SalesAnalyst.new(se)

    assert_equal 3.29, sa.average_invoices_per_merchant_standard_deviation
  end

  def test_top_merchants_by_invoice_count
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    })
    sa = SalesAnalyst.new(se)

    assert_equal 4, sa.top_merchants_by_invoice_count.length

  end

  def test_top_merchants_by_invoice_count
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    })
    sa = SalesAnalyst.new(se)

    assert_equal 16, sa.bottom_merchants_by_invoice_count.length

  end

  def test_it_calculates_top_days_by_invoice_count
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => './data/invoices.csv'
    })
    sa = SalesAnalyst.new(se)
    assert_equal [["Wednesday", 741]], sa.top_days_by_invoice_count
  end

  def test_it_calculates_percentage_of_invoices_status
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => './data/invoices.csv'
    })
    sa = SalesAnalyst.new(se)
    assert_equal 29.55, sa.invoice_status(:pending)
    assert_equal 56.95, sa.invoice_status(:shipped)
    assert_equal 13.5, sa.invoice_status(:returned)
  end

end
