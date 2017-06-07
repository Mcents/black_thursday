require './test/test_helper'
require_relative '../lib/customer'
require 'pry'
require 'time'

class CustomerTest < MiniTest::Test

  def setup
    cust_created_at = '2017-05-27 15:44:02 UTC'
    cust_updated_at = '2017-05-29 14:56:56 UTC'
    @cr = Customer.new({
    :id => 1,
    :first_name => "Joey",
    :last_name => "Ondricka",
    :created_at  => cust_created_at,
    :updated_at  => cust_updated_at,
    }, cr = nil)
  end

  def test_it_can_call_on_id

    assert_equal 1, @cr.id
  end

  def test_it_can_call_on_first_name

    assert_equal "Joey", @cr.first_name
  end

  def test_it_can_call_on_last_name

    assert_equal "Ondricka", @cr.last_name
  end


  def test_item_has_a_create_date
    created_at = Time.gm(2017, 5, 27, 15, 44, 2)

    assert_equal created_at, @cr.created_at
  end

  def test_item_has_an_update_date
    updated_at = Time.gm(2017, 5, 29, 14, 56, 56)

    assert_equal updated_at, @cr.updated_at
  end
end
