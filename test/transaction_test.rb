require './test/test_helper'
require_relative '../lib/transaction'
require 'pry'
require 'time'

class InvoiceItemTest < MiniTest::Test

  def setup
    trans_created_at = '2017-05-27 15:44:02 UTC'
    trans_updated_at = '2017-05-29 14:56:56 UTC'
    @tr = Transaction.new({
    :id => 1,
    :invoice_id => 3715,
    :credit_card_number => "4068631943231473",
    :credit_card_expiration_date => "0217",
    :result => "success",
    :created_at  => trans_created_at,
    :updated_at  => trans_updated_at,
    }, tr = nil)
  end

  def test_it_can_call_on_id

    assert_equal 1, @tr.id
  end

  def test_it_can_call_on_cc_number

    assert_equal 4068631943231473, @tr.credit_card_number
  end

  def test_it_can_call_on_expiration_date

    assert_equal "0217", @tr.credit_card_expiration_date
  end

  def test_it_can_call_on_transaction_id

    assert_equal 3715, @tr.invoice_id
  end

  def test_it_can_call_on_result

    assert_equal "success", @tr.result
  end

  def test_item_has_a_create_date
    created_at = Time.gm(2017, 5, 27, 15, 44, 2)

    assert_equal created_at, @tr.created_at
  end

  def test_item_has_an_update_date
    updated_at = Time.gm(2017, 5, 29, 14, 56, 56)

    assert_equal updated_at, @tr.updated_at
  end
end
