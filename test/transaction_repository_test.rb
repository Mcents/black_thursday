require 'bigdecimal'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/transaction_repository'
require 'csv'
require 'time'


class TransactionRepositoryTest < MiniTest::Test

  def test_it_can_find_by_id
    tr = TransactionRepository.new('./test/data/transactions_fixture.csv', sales_engine = nil)
    id = 2
    trans = tr.find_by_id(id)

    assert_equal trans.id, id
    assert_instance_of Transaction, trans
  end

  # def test_it_can_find_all_by_item_id
  #   ir = InvoiceItemRepository.new('./test/data/invoice_items_fixture.csv', sales_engine = nil)
  #   invoice = ir.find_all_by_item_id(263542298)
  #
  #   assert_equal 1, invoice.count
  # end
  #
  # def test_it_can_find_all_by_item_id
  #   ir = InvoiceItemRepository.new('./test/data/invoice_items_fixture.csv', sales_engine = nil)
  #   invoice = ir.find_all_by_invoice_id(2)
  #
  #   assert_equal 1, invoice.count
  # end


end
