# require 'simplecov'
# SimpleCov.start
require './test/test_helper'
require_relative '../lib/merchant'
require 'pry'


class MerchantTest < MiniTest::Test


  def setup
    @merchant = Merchant.new({:id => 1, :name => "Burger King"}, mr = nil)
  end

  def test_it_can_call_on_id

    assert_equal 1, @merchant.id
  end

  def test_it_can_call_on_name

    assert_equal "Burger King", @merchant.name
  end




end
