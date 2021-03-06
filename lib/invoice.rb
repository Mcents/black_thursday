require 'pry'
require 'time'

class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :iv_repo

  def initialize(hash, iv_repo)
    @iv_repo     = iv_repo
    @id          = hash[:id].to_i
    @customer_id = hash[:customer_id].to_i
    @merchant_id = hash[:merchant_id].to_i
    @status      = hash[:status].to_sym
    @created_at  = Time.parse(hash[:created_at])
    @updated_at  = Time.parse(hash[:updated_at])
  end

  def merchant
    @iv_repo.merchant(self.merchant_id)
  end

  def items
    @iv_repo.items_in_invoice_repo(id)
  end

  def transactions
    @iv_repo.transactions_in_inv_repo(id)
  end

  def invoice_items
    @iv_repo.sales_engine.invoice_items.find_all_by_invoice_id(id)
  end

  def customer
    @iv_repo.customer_in_inv_repo(@customer_id)
  end

  def is_paid_in_full?
    transactions.any? do |transaction|
      transaction.result == 'success'
    end
  end

  def total
    if is_paid_in_full? == true
      @iv_repo.total(@id)
    end
  end

  def invoice_count
    return 0.0 unless is_paid_in_full?
    @iv_repo.sales_engine.invoice_items.all.inject(0) do |sum, invoice_item|
      sum + invoice_item.unit_price * invoice_item.quantity
    end
  end

end
