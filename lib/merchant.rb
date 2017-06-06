class Merchant
  attr_reader  :id,
               :name

  def initialize(hash, mr)
    @id   = hash[:id].to_i
    @name = hash[:name]
    @mr = mr
  end

  def items
    @mr.items_in_merch_repo(id)
  end

  def invoices
    @mr.invoices_in_merch_repo(id)
  end

  def customers
    @mr.customers_in_merch_repo(id)
  end

  def successful_invoices
    invoices.find_all { |invoice| invoice.is_paid_in_full? }
  end

  def revenue_for_merchant
    successful_invoices.reduce(0) do |total, invoice|
      if invoice.total.nil?
        total += 0
      else
        total += invoice.total
      end
      total
    end
  end

end
