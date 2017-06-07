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


    # def test_it_can_call_on_unit_price
    #
    #   assert_equal BigDecimal.new(10.99,4), @item.unit_price
    # end
    #
    # def test_it_can_call_on_merchant_id
    #
    #   assert_equal 12345678, @item.merchant_id
    # end
    #
    # def test_item_has_a_create_date
    #   created_at = Time.gm(2017, 5, 27, 15, 44, 2)
    #
    #   assert_equal created_at, @item.created_at
    # end
    #
    # def test_item_has_an_update_date
    #   updated_at = Time.gm(2017, 5, 29, 14, 56, 56)
    #
    #   assert_equal updated_at, @item.updated_at
    # end
    #
    # def test_unit_price_to_dollars_returns_a_float
    #   assert_equal @item.unit_price_to_dollars.class, Float
    #   assert_equal @item.unit_price_to_dollars, 10.99
    #
    # end




end
