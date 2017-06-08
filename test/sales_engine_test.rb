require './test/test_helper'
require_relative '../lib/sales_engine'
require 'pry'
require 'csv'


class SalesEngineTest < MiniTest::Test

  def test_child_instances_created
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"})
    assert_instance_of ItemRepository, se.items
    assert_instance_of MerchantRepository, se.merchants
    assert_instance_of InvoiceRepository, se.invoices
  end

  def test_items_searched_by_id
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv",
    :customers => "./data/customers.csv"})
    items = se.items
    assert_instance_of Item, items.find_by_id(263395237)
  end

  def test_items_searched_by_all_price
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv",
    :customers => "./data/customers.csv"})
    items = se.items

    assert_equal 9, items.find_all_by_price(300).length
    refute_equal 2, items.find_all_by_price(300).length
  end

  def test_items_searched_by_name
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv",
    :customers => "./data/customers.csv"})
    items = se.items

    assert_instance_of Item, items.find_by_name("Glitter scrabble frames")
  end

  def test_items_searched_by_merchant_id
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv",
    :customers => "./data/customers.csv"})
    items = se.items

    assert_equal 1, items.find_all_by_merchant_id(12334141).length
    refute_equal 2, items.find_all_by_merchant_id(12334141).length
  end

  def test_find_merchant_invoices
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv",
    :customers => "./data/customers.csv"})
    merchant = se.merchants.find_by_id(12334141)

    assert_equal 18, merchant.invoices.count
    assert_equal 641, merchant.invoices.first.id
  end

  def test_find_invoice_merchant
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv",
    :customers => "./data/customers.csv"})
    invoice = se.invoices.find_by_id(303)

    assert_equal "AgeofSplendor", invoice.merchant.name
  end

  def test_transactions_invoice
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv",
    :customers => "./data/customers.csv"})
    transaction = se.transactions.find_by_id(992)

    assert_equal 1978, transaction.invoice.id
    assert_instance_of Invoice, transaction.invoice
  end

  def test_invoice_items
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv",
    :customers => "./data/customers.csv"})
    invoice = se.invoices.find_by_id(1012)

    assert_equal 2, invoice.items.count
    assert_instance_of Item, invoice.items[0]
  end

  def test_invoice_transactions
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv",
    :customers => "./data/customers.csv"})
    invoice = se.invoices.find_by_id(3000)

    assert_equal 2, invoice.transactions.count
    assert_instance_of Transaction, invoice.transactions[0]
  end

  def test_is_paid_in_full?
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv",
    :customers => "./data/customers.csv"})
    invoice = se.invoices.find_by_id(4966)
    assert invoice.is_paid_in_full?
  end

  def test_invoice_customer
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv",
    :customers => "./data/customers.csv"})
    invoice = se.invoices.find_by_id(4966)
    assert_equal 996, invoice.customer.id
    assert_instance_of Customer, invoice.customer
  end


end
