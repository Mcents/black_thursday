require 'bigdecimal'
require './test/test_helper'
require_relative '../lib/invoice'
require 'pry'

class InvoiceTest < MiniTest::Test

    def setup
      item_created_at = '2017-05-27 15:44:02 UTC'
      item_updated_at = '2017-05-29 14:56:56 UTC'
      @invoice = Invoice.new({
      :id           => 2,
      :customer_id  => 1,
      :merchant_id  => 12335938,
      :created_at   => item_created_at,
      :updated_at   => item_updated_at,
      :status       => :pending,
      }, iv_repo = nil)
    end

    def test_it_can_call_on_id

      assert_equal 2, @invoice.id
      refute_equal 10, @invoice.id
    end

    def test_it_can_call_on_customer_id

      assert_equal 1, @invoice.customer_id
      refute_equal 9, @invoice.customer_id
    end

    def test_it_can_call_on_merchant_id

      assert_equal 12335938, @invoice.merchant_id
      refute_equal 21523555, @invoice.merchant_id
    end

    def test_it_can_call_on_status

      assert_equal :pending, @invoice.status
      refute_equal :shipped, @invoice.status
    end

    def test_item_has_a_create_date
      created_at = Time.gm(2017, 5, 27, 15, 44, 2)

      assert_equal created_at, @invoice.created_at
    end

    def test_item_has_an_update_date
      updated_at = Time.gm(2017, 5, 29, 14, 56, 56)

      assert_equal updated_at, @invoice.updated_at
    end
end
