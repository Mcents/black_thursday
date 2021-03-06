require 'pry'
require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'
require 'csv'

class SalesEngine
  attr_reader :merchants,
              :items,
              :invoices,
              :invoice_items,
              :transactions,
              :customers


  def initialize(hash)
    @items = ItemRepository.new(hash[:items], self)
    @merchants = MerchantRepository.new(hash[:merchants], self)
    @invoices = InvoiceRepository.new(hash[:invoices], self)
    @invoice_items = InvoiceItemRepository.new(hash[:invoice_items], self)
    @transactions = TransactionRepository.new(hash[:transactions], self)
    @customers = CustomerRepository.new(hash[:customers], self)
  end

  def self.from_csv(hash)
    SalesEngine.new(hash)
  end

  def collected_invoices(merchant_id)
    @invoices.find_all_by_merchant_id(merchant_id)
  end

  def collected_items(merchant_id)
    @items.find_all_by_merchant_id(merchant_id)
  end

  def merchant(item_id)
    @merchants.merchant(item_id)
  end

  def collected_transactions(invoice_id)
    @transactions.find_all_by_invoice_id(invoice_id)
  end

  def collected_customers(id)
    @customers.find_by_id(id)
  end

  def find_customers_by_merchant_id(merchant_id)
    result = @invoices.find_all_by_merchant_id(merchant_id)
    result = iterate_customers(result)
    customers_by_id(result)
  end

  def find_invoice_by_transaction_invoice_id(invoice_id)
    @invoices.find_by_id(invoice_id)
  end

  def find_merchants_by_customer_id(customer_id)
    invoices = @invoices.find_all_by_customer_id(customer_id)
    merchant_ids = iterate_merchants(invoices)
    merchants_by_id(merchant_ids)
  end

  def find_invoice_items_by_invoice_id(invoice_id)
    result = @invoice_items.find_all_by_invoice_id(invoice_id)
    result = iterate_item_ids(result)
    multiple_item_ids(result)
  end

  def iterate_customers(invoices)
    invoices = invoices.map do |invoice|
      invoice.customer_id
    end
  end

  def iterate_merchants(invoices)
    invoices = invoices.map do |invoice|
      invoice.merchant_id
    end
  end

  def iterate_item_ids(result)
    result = result.map do |invoice_item|
      invoice_item.item_id
    end
  end

  def customers_by_id(customer_ids)
    @customers.customers_by_id(customer_ids)
  end

  def merchants_by_id(merchant_ids)
    @merchants.merchants_by_id(merchant_ids)
  end

  def multiple_item_ids(item_ids)
    @items.find_by_multiple_item_ids(item_ids)
  end

  def total(id)
    @invoice_items.total(id)
  end

  def is_paid_in_full?(invoice_id)
    @transactions.is_paid_in_full?(invoice_id)
  end

end
