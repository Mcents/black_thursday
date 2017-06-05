require 'bigdecimal'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_item_repository'
require 'csv'
require 'time'


class InvoiceItemRepositoryTest < MiniTest::Test

  def test_it_can_find_by_id
    ir = InvoiceItemRepository.new('./test/data/invoice_items_fixture.csv', sales_engine = nil)
    id = 2
    invoice = ir.find_by_id(id)

    assert_equal invoice.id, id
    assert_instance_of InvoiceItem, invoice
  end





end
