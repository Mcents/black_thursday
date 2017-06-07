require './test/test_helper'
require_relative '../lib/invoice_item'
require 'pry'
require 'bigdecimal'
require 'time'

class InvoiceItemTest < MiniTest::Test

  def setup
    item_created_at = '2017-05-27 15:44:02 UTC'
    item_updated_at = '2017-05-29 14:56:56 UTC'
    @item = InvoiceItem.new({
    :id => 1,
    :item_id => 263454779,
    :invoice_id => 1,
    :quantity => 5,
    :unit_price  => "1099",
    :created_at  => item_created_at,
    :updated_at  => item_updated_at,
    }, iv_item_repo = nil)
  end

  def test_it_can_call_on_id

    assert_equal 1, @item.id
  end

  def test_it_can_call_on_item_id

    assert_equal 263454779, @item.item_id
  end


  def test_it_can_call_on_invoice_id

    assert_equal 1, @item.invoice_id
  end

  def test_item_has_a_create_date
    created_at = Time.gm(2017, 5, 27, 15, 44, 2)

    assert_equal created_at, @item.created_at
  end

  def test_item_has_an_update_date
    updated_at = Time.gm(2017, 5, 29, 14, 56, 56)

    assert_equal updated_at, @item.updated_at
  end
end
