require 'csv'
require_relative 'transaction'

class TransactionRepository
  attr_reader :all,
              :sales_engine

  def initialize(file, sales_engine)
    @all = []
    @sales_engine = sales_engine
    populate_transaction_repo(file)
  end

  def populate_transaction_repo(file)
    tran_lines = CSV.open(file, headers: true, header_converters: :symbol)
    tran_lines.each do |row|
      tran = Transaction.new(row, self)
      all << tran
    end
    tran_lines.close
  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end

  def find_by_id(id)
    all.find do |tran|
      tran.id == id
    end
  end

  def find_all_by_invoice_id(id)
    all.find_all do |tran|
     tran.invoice_id == id
    end
  end

  def find_all_by_credit_card_number(number)
    all.find_all do |tran|
     tran.credit_card_number == number
    end
  end

  def find_all_by_result(result)
    all.find_all do |tran|
     tran.result == result
    end
  end

  def invoices_in_trans_repo(id)
    @sales_engine.collected_transactions(id)
  end


end
