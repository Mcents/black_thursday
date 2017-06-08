require './test/test_helper'
require_relative '../lib/invoice_item'
require 'pry'
require 'bigdecimal'
require 'time'

class InvoiceItemTest < MiniTest::Test

  def test_it_can_call_on_id
    item_created_at = '2017-05-27 15:44:02 UTC'
    item_updated_at = '2017-05-29 14:56:56 UTC'
    @ii = InvoiceItem.new({
    :id => 1,
    :item_id => 263454779,
    :invoice_id => 1,
    :quantity => 5,
    :unit_price  => 1099,
    :created_at  => item_created_at,
    :updated_at  => item_updated_at,
    }, iv_item_repo = nil)

    assert_equal 1, @ii.id
  end

  def test_it_can_call_on_item_id
    item_created_at = '2017-05-27 15:44:02 UTC'
    item_updated_at = '2017-05-29 14:56:56 UTC'
    @ii = InvoiceItem.new({
    :id => 1,
    :item_id => 263454779,
    :invoice_id => 1,
    :quantity => 5,
    :unit_price  => 1099,
    :created_at  => item_created_at,
    :updated_at  => item_updated_at,
    }, iv_item_repo = nil)

    assert_equal 263454779, @ii.item_id
  end

  def test_it_can_call_on_invoice_id
    item_created_at = '2017-05-27 15:44:02 UTC'
    item_updated_at = '2017-05-29 14:56:56 UTC'
    @ii = InvoiceItem.new({
    :id => 1,
    :item_id => 263454779,
    :invoice_id => 1,
    :quantity => 5,
    :unit_price  => 1099,
    :created_at  => item_created_at,
    :updated_at  => item_updated_at,
    }, iv_item_repo = nil)

    assert_equal 1, @ii.invoice_id
  end

  def test_item_has_a_create_date
    item_created_at = '2017-05-27 15:44:02 UTC'
    item_updated_at = '2017-05-29 14:56:56 UTC'
    @ii = InvoiceItem.new({
    :id => 1,
    :item_id => 263454779,
    :invoice_id => 1,
    :quantity => 5,
    :unit_price  => 1099,
    :created_at  => item_created_at,
    :updated_at  => item_updated_at,
    }, iv_item_repo = nil)
    created_at = Time.gm(2017, 5, 27, 15, 44, 2)

    assert_equal created_at, @ii.created_at
  end

  def test_item_has_an_update_date
    item_created_at = '2017-05-27 15:44:02 UTC'
    item_updated_at = '2017-05-29 14:56:56 UTC'
    @ii = InvoiceItem.new({
    :id => 1,
    :item_id => 263454779,
    :invoice_id => 1,
    :quantity => 5,
    :unit_price  => 1099,
    :created_at  => item_created_at,
    :updated_at  => item_updated_at,
    }, iv_item_repo = nil)
    updated_at = Time.gm(2017, 5, 29, 14, 56, 56)

    assert_equal updated_at, @ii.updated_at
  end

  def test_it_gets_the_unit_price
    item_created_at = '2017-05-27 15:44:02 UTC'
    item_updated_at = '2017-05-29 14:56:56 UTC'
    @ii = InvoiceItem.new({
    :id => 1,
    :item_id => 263454779,
    :invoice_id => 1,
    :quantity => 5,
    :unit_price  => 1099,
    :created_at  => item_created_at,
    :updated_at  => item_updated_at,
    }, iv_item_repo = nil)
    i = @ii.unit_price
    assert_instance_of BigDecimal, i
  end

  def test_it_converts_unit_price_to_dollars
    item_created_at = '2017-05-27 15:44:02 UTC'
    item_updated_at = '2017-05-29 14:56:56 UTC'
    @ii = InvoiceItem.new({
    :id => 1,
    :item_id => 263454779,
    :invoice_id => 1,
    :quantity => 5,
    :unit_price  => 1099,
    :created_at  => item_created_at,
    :updated_at  => item_updated_at,
    }, iv_item_repo = nil)

    assert_equal 10.99, @ii.unit_price_to_dollars
  end

end
