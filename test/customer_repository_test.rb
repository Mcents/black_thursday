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

  # def test_it_can_find_all_invoice_id
  #   tr = TransactionRepository.new('./test/data/transactions_fixture.csv', sales_engine = nil)
  #   trans = tr.find_all_by_invoice_id(2179)
  #
  #   assert_equal 1, trans.count
  # end
  #
  # def test_it_can_find_all_by_credit_card_number
  #   tr = TransactionRepository.new('./test/data/transactions_fixture.csv', sales_engine = nil)
  #   trans = tr.find_all_by_credit_card_number(4068631943231473)
  #
  #   assert_equal 1, trans.count
  # end
  #
  # def test_it_can_find_all_by_result
  #   tr = TransactionRepository.new('./test/data/transactions_fixture.csv', sales_engine = nil)
  #   trans = tr.find_all_by_result(:success)
  #
  #   assert_equal 8, trans.count
  # end
end
