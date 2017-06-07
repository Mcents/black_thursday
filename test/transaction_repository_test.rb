require 'bigdecimal'
require './test/test_helper'
require_relative '../lib/transaction_repository'
require 'csv'
require 'time'


class TransactionRepositoryTest < MiniTest::Test

  def test_it_can_find_by_id
    tr = TransactionRepository.new('./test/data/transactions_fixture.csv', sales_engine = nil)
    id = 2
    trans = tr.find_by_id(id)

    assert_equal trans.id, id
    assert_instance_of Transaction, trans
  end

  def test_it_can_find_all_invoice_id
    tr = TransactionRepository.new('./test/data/transactions_fixture.csv', sales_engine = nil)
    trans = tr.find_all_by_invoice_id(2179)

    assert_equal 1, trans.count
  end

  def test_it_can_find_all_by_credit_card_number
    tr = TransactionRepository.new('./test/data/transactions_fixture.csv', sales_engine = nil)
    trans = tr.find_all_by_credit_card_number(4068631943231473)

    assert_equal 1, trans.count
    assert tr.find_all_by_credit_card_number("abcde").is_a?(Array)
    assert_equal 0, tr.find_all_by_credit_card_number("vabcde").length
  end

  def test_it_can_find_all_by_result
    tr = TransactionRepository.new('./test/data/transactions_fixture.csv', sales_engine = nil)
    trans = tr.find_all_by_result("success")

    assert_equal 8, trans.count
    assert tr.find_all_by_result(756879).is_a?(Array)
    assert_equal 0, tr.find_all_by_result(753479).length
  end
end
