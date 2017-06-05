require 'bigdecimal'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/customer_repository'
require 'csv'
require 'time'


class CustomerRepositoryTest < MiniTest::Test

  def test_it_can_find_by_id
    cr = CustomerRepository.new('./test/data/customers_fixture.csv', sales_engine = nil)
    id = 1
    cust = cr.find_by_id(id)

    assert_equal cust.id, id
    assert_instance_of Customer, cust
  end

  def test_it_can_find_all_by_first_name
    cr = CustomerRepository.new('./test/data/customers_fixture.csv', sales_engine = nil)
    cust = cr.find_all_by_first_name("Joey")

    assert_equal 1, cust.count
  end

  def test_it_can_find_all_by_first_name
    cr = CustomerRepository.new('./test/data/customers_fixture.csv', sales_engine = nil)
    cust = cr.find_all_by_last_name("Ondricka")

    assert_equal 1, cust.count
  end
end
